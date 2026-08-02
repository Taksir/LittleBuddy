import Foundation
import SwiftUI
import Combine

@MainActor
final class AudioRiddleEngine: ObservableObject {
    @Published private(set) var riddles: [AudioRiddle] = []
    @Published private(set) var currentRiddleIndex: Int = 0
    @Published private(set) var currentOptions: [AudioRiddleOption] = []
    
    @Published var score: Int = 0
    @Published var firstTryCount: Int = 0
    @Published var hintsCount: Int = 0
    @Published var selectedOptionID: String? = nil
    @Published var isCorrectFeedback: Bool = false
    @Published var isIncorrectFeedback: Bool = false
    @Published var feedbackMessage: String = "Listen to the clue, then tap the matching picture!"
    @Published var isCompleted: Bool = false
    @Published var hasAttemptedCurrent: Bool = false

    init() {
        startNewSession()
    }

    func startNewSession() {
        self.riddles = AudioRiddleCatalog.riddles.shuffled()
        self.currentRiddleIndex = 0
        self.score = 0
        self.firstTryCount = 0
        self.hintsCount = 0
        self.isCompleted = false
        self.selectedOptionID = nil
        self.isCorrectFeedback = false
        self.isIncorrectFeedback = false
        loadCurrentRiddle()
    }

    private func loadCurrentRiddle() {
        guard currentRiddleIndex < riddles.count else {
            isCompleted = true
            feedbackMessage = "🎉 You solved all the Audio Riddles! Excellent listening!"
            return
        }

        let r = riddles[currentRiddleIndex]
        self.currentOptions = r.options.shuffled()
        self.selectedOptionID = nil
        self.isCorrectFeedback = false
        self.isIncorrectFeedback = false
        self.hasAttemptedCurrent = false
        self.feedbackMessage = "Listen to the clue: \"\(r.clueText)\""
    }

    var currentRiddle: AudioRiddle? {
        guard currentRiddleIndex < riddles.count else { return nil }
        return riddles[currentRiddleIndex]
    }

    func tapOption(_ option: AudioRiddleOption) {
        if isCorrectFeedback || isCompleted { return }

        selectedOptionID = option.id

        if option.isCorrect {
            isCorrectFeedback = true
            isIncorrectFeedback = false
            score += 1
            if !hasAttemptedCurrent {
                firstTryCount += 1
            }
            feedbackMessage = "⭐ That's right! It's \(option.title)!"
        } else {
            hasAttemptedCurrent = true
            isIncorrectFeedback = true
            isCorrectFeedback = false
            hintsCount += 1
            if let hint = currentRiddle?.hintText {
                feedbackMessage = "Try again! Hint: \(hint)"
            } else {
                feedbackMessage = "Not quite! Listen closely and try another picture."
            }
        }
    }

    func nextRiddle() {
        if currentRiddleIndex + 1 < riddles.count {
            currentRiddleIndex += 1
            loadCurrentRiddle()
        } else {
            isCompleted = true
            feedbackMessage = "🎉 You solved all the Audio Riddles! Fantastic job!"
        }
    }

    func playAudioPrompt() {
        if let clue = currentRiddle?.clueText {
            feedbackMessage = "🔊 Listening: \"\(clue)\""
        }
    }
}
