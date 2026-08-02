import Foundation
import SwiftUI
import Combine

@MainActor
final class StorySequencerEngine: ObservableObject {
    let book: StoryBook
    let level: Int
    let sessionToken: UUID

    @Published private(set) var targetCards: [SequencerCard] = []
    @Published private(set) var poolCards: [SequencerCard] = []
    @Published private(set) var placedSlots: [SequencerCard?] = []
    @Published var selectedCard: SequencerCard? = nil
    
    @Published var isCompleted: Bool = false
    @Published var feedbackMessage: String = "Tap a card or slot to put the story in order!"
    @Published var isIncorrectFeedback: Bool = false
    @Published var attemptsCount: Int = 0
    @Published var hintsCount: Int = 0
    @Published var isAudioPlaying: Bool = false
    @Published var currentPlayingCardID: String? = nil

    private let startTime: Date = Date()

    init(book: StoryBook, level: Int, sessionToken: UUID) {
        self.book = book
        self.level = max(3, min(5, level))
        self.sessionToken = sessionToken
        setupCards()
    }

    private func setupCards() {
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
        
        // Shuffle pool until it's not identical to sorted order
        var shuffled = cards.shuffled()
        if shuffled == cards && cards.count > 1 {
            shuffled.reverse()
        }
        self.poolCards = shuffled
    }

    func tapPoolCard(_ card: SequencerCard) {
        if isCompleted { return }
        
        // If card is already selected, unselect it
        if selectedCard == card {
            selectedCard = nil
            return
        }

        // If an empty slot exists, place it directly in the first empty slot
        if let firstEmptyIndex = placedSlots.firstIndex(where: { $0 == nil }) {
            placeCard(card, inSlot: firstEmptyIndex)
            selectedCard = nil
        } else {
            // Select it for swapping
            selectedCard = card
        }
    }

    func tapSlot(_ slotIndex: Int) {
        if isCompleted || slotIndex < 0 || slotIndex >= placedSlots.count { return }

        // If we have a selected card from the pool, place it in this slot
        if let card = selectedCard {
            // If slot already has a card, return existing card to pool
            if let existingCard = placedSlots[slotIndex] {
                poolCards.append(existingCard)
            }
            placedSlots[slotIndex] = card
            poolCards.removeAll(where: { $0.id == card.id })
            selectedCard = nil
            checkAutomaticCheck()
            return
        }

        // If slot is occupied and no card selected, remove it back to pool
        if let existingCard = placedSlots[slotIndex] {
            placedSlots[slotIndex] = nil
            poolCards.append(existingCard)
            isIncorrectFeedback = false
            feedbackMessage = "Card returned to pool."
        }
    }

    private func placeCard(_ card: SequencerCard, inSlot slotIndex: Int) {
        if let existing = placedSlots[slotIndex] {
            poolCards.append(existing)
        }
        placedSlots[slotIndex] = card
        poolCards.removeAll(where: { $0.id == card.id })
        checkAutomaticCheck()
    }

    func playNarration(for card: SequencerCard) {
        currentPlayingCardID = card.id
        isAudioPlaying = true
        feedbackMessage = "\"\(card.narrationSnippet)\""
    }

    func resetBoard() {
        setupCards()
        isCompleted = false
        selectedCard = nil
        isIncorrectFeedback = false
        feedbackMessage = "Tap a card or slot to put the story in order!"
    }

    private func checkAutomaticCheck() {
        // When all slots are filled, automatically evaluate
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
        } else {
            isCompleted = false
            isIncorrectFeedback = true
            hintsCount += 1
            feedbackMessage = "Not quite! Tap audio to hear what happens first, then try again!"
        }
    }

    var isAllSlotsFilled: Bool {
        placedSlots.allSatisfy { $0 != nil }
    }
}
