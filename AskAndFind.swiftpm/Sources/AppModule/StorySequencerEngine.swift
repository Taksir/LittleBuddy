import Foundation
import SwiftUI
import Combine

@MainActor
final class StorySequencerEngine: ObservableObject {
    let book: StoryBook
    let level: Int

    @Published private(set) var targetCards: [SequencerCard] = []
    @Published private(set) var poolCards: [SequencerCard] = []
    @Published private(set) var placedSlots: [SequencerCard?] = []
    @Published var selectedCard: SequencerCard? = nil
    
    @Published var isCompleted: Bool = false
    @Published var feedbackMessage: String = "Tap a card or slot to put the story in order!"
    @Published var isIncorrectFeedback: Bool = false
    @Published var attemptsCount: Int = 0
    @Published var hintsCount: Int = 0

    private var sessionToken: UUID
    private var startTime: Date = Date()
    private var hasSavedSession: Bool = false
    private let speechGuide = SpeechGuide()

    init(book: StoryBook, level: Int, sessionToken: UUID) {
        self.book = book
        self.level = max(3, min(5, level))
        self.sessionToken = sessionToken
        setupCards()
    }

    private func setupCards() {
        speechGuide.stop()
        let pages = book.pages.sorted(by: { $0.order < $1.order })
        guard !pages.isEmpty else { return }

        var selectedPageIndices: [Int] = []
        if level == 3 {
            // Beginning, Middle, End
            selectedPageIndices = [0, pages.count / 2, pages.count - 1]
        } else if level == 4 {
            selectedPageIndices = [0, 3, 6, pages.count - 1]
        } else {
            // 5 cards
            selectedPageIndices = [0, 2, 4, 7, pages.count - 1]
        }

        let cards = selectedPageIndices.compactMap { idx -> SequencerCard? in
            guard idx < pages.count else { return nil }
            let p = pages[idx]
            return SequencerCard(
                id: p.id,
                pageOrder: p.order,
                pageTitle: p.title,
                imageAsset: p.imageAsset,
                narrationSnippet: p.narrationTranscript,
                altText: p.altText
            )
        }

        self.targetCards = cards
        self.placedSlots = Array(repeating: nil, count: cards.count)
        
        // Shuffle pool and ensure initial order is NOT already equal to the target order
        var shuffled = cards.shuffled()
        if shuffled == cards && cards.count > 1 {
            shuffled.reverse()
        }
        self.poolCards = shuffled
        self.selectedCard = nil
    }

    // MARK: - State Machine & Card Interactions

    func tapPoolCard(_ card: SequencerCard) {
        if isCompleted { return }

        // If this card is already selected, unselect it
        if selectedCard == card {
            selectedCard = nil
            return
        }

        // Select the card
        selectedCard = card
    }

    func tapSlot(_ slotIndex: Int) {
        guard !isCompleted, slotIndex >= 0, slotIndex < placedSlots.count else { return }

        // CASE 1: A card is currently selected
        if let selCard = selectedCard {
            // Check if selected card came from the pool
            if let poolIndex = poolCards.firstIndex(where: { $0.id == selCard.id }) {
                // If target slot is occupied, move occupant to pool
                if let existingInSlot = placedSlots[slotIndex] {
                    poolCards[poolIndex] = existingInSlot
                } else {
                    poolCards.remove(at: poolIndex)
                }
                placedSlots[slotIndex] = selCard
                selectedCard = nil
                checkAutomaticCheck()
                return
            }

            // Selected card came from another slot
            if let sourceSlotIndex = placedSlots.firstIndex(where: { $0?.id == selCard.id }) {
                if sourceSlotIndex == slotIndex {
                    // Tapped the same slot: unselect
                    selectedCard = nil
                } else {
                    // SWAP cards between sourceSlotIndex and slotIndex
                    let targetSlotCard = placedSlots[slotIndex]
                    placedSlots[slotIndex] = selCard
                    placedSlots[sourceSlotIndex] = targetSlotCard
                    selectedCard = nil
                    checkAutomaticCheck()
                }
                return
            }

            selectedCard = nil
            return
        }

        // CASE 2: No card currently selected
        if let existingCard = placedSlots[slotIndex] {
            // Select the card in this slot for swapping/moving
            selectedCard = existingCard
        }
    }

    func removeCardFromSlot(_ slotIndex: Int) {
        guard slotIndex >= 0, slotIndex < placedSlots.count, let card = placedSlots[slotIndex] else { return }
        placedSlots[slotIndex] = nil
        if !poolCards.contains(where: { $0.id == card.id }) {
            poolCards.append(card)
        }
        if selectedCard == card {
            selectedCard = nil
        }
        isIncorrectFeedback = false
        feedbackMessage = "Card returned to pool."
    }

    private func placePoolCard(_ card: SequencerCard, inSlot slotIndex: Int) {
        guard slotIndex >= 0, slotIndex < placedSlots.count else { return }
        if let existing = placedSlots[slotIndex] {
            poolCards.append(existing)
        }
        placedSlots[slotIndex] = card
        poolCards.removeAll(where: { $0.id == card.id })
        checkAutomaticCheck()
    }

    // MARK: - Audio Speech Integration

    func playNarration(for card: SequencerCard) {
        speechGuide.stop()
        feedbackMessage = "\"\(card.narrationSnippet)\""
        speechGuide.speak(card.narrationSnippet)
    }

    func stopSpeech() {
        speechGuide.stop()
        saveSessionIfNeeded()
    }

    func resetBoard() {
        speechGuide.stop()
        saveSessionIfNeeded()
        self.sessionToken = UUID()
        self.startTime = Date()
        self.hasSavedSession = false
        setupCards()
        isCompleted = false
        selectedCard = nil
        isIncorrectFeedback = false
        attemptsCount = 0
        hintsCount = 0
        feedbackMessage = "Tap a card or slot to put the story in order!"
    }

    // MARK: - Evaluation & Invariants

    private func checkAutomaticCheck() {
        if placedSlots.allSatisfy({ $0 != nil }) {
            verifySequence()
        } else {
            let filledCount = placedSlots.compactMap({ $0 }).count
            feedbackMessage = "\(filledCount) of \(level) placed. Keep going!"
            isIncorrectFeedback = false
        }
    }

    func verifySequence() {
        attemptsCount += 1
        
        let currentIDs = placedSlots.compactMap { $0?.id }
        let targetIDs = targetCards.map { $0.id }

        if currentIDs == targetIDs {
            isCompleted = true
            isIncorrectFeedback = false
            feedbackMessage = "🌟 Perfect! You put the story in the right order!"
            speechGuide.stop()
            speechGuide.speak("Perfect! You put the story in the right order!")
            saveSessionIfNeeded()
        } else {
            isCompleted = false
            isIncorrectFeedback = true
            hintsCount += 1
            feedbackMessage = "Not quite! Tap the speaker icon to listen, then swap cards."
            speechGuide.stop()
            speechGuide.speak("Not quite! Tap the speaker to listen, then try swapping cards.")
        }
    }

    func saveSessionIfNeeded() {
        guard !hasSavedSession else { return }
        guard attemptsCount > 0 || isCompleted else { return }

        hasSavedSession = true
        let duration = max(1, Int(Date().timeIntervalSince(startTime)))
        let record = StorySequencerRecord(
            id: sessionToken,
            storyID: book.id,
            level: level,
            date: Date(),
            attempts: attemptsCount,
            hintsUsed: hintsCount,
            completedSuccessfully: isCompleted,
            durationSeconds: duration
        )
        StorySequencerProgressStore.shared.add(record)
    }

    var isAllSlotsFilled: Bool {
        placedSlots.allSatisfy { $0 != nil }
    }

    /// Invariant Check for Unit Tests: Every target card must exist in pool, slots, or selected state (disjoint & complete).
    var isBoardInvariantValid: Bool {
        let poolIDs = poolCards.map(\.id)
        let slotIDs = placedSlots.compactMap(\.id)
        let allPresentIDs = poolIDs + slotIDs

        let noDuplicates = Set(allPresentIDs).count == allPresentIDs.count
        let targetSet = Set(targetCards.map(\.id))
        let currentSet = Set(allPresentIDs)

        let setsMatch = currentSet == targetSet
        let countMatches = allPresentIDs.count == targetCards.count
        let noOverlap = Set(poolIDs).isDisjoint(with: Set(slotIDs))

        var selectedValid = true
        if let sel = selectedCard {
            selectedValid = allPresentIDs.contains(sel.id)
        }

        return noDuplicates && setsMatch && countMatches && noOverlap && selectedValid
    }
}
