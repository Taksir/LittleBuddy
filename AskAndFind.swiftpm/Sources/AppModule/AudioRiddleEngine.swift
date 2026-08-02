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

    private var sessionToken: UUID = UUID()
    private var startTime: Date = Date()
    private var hasSavedSession: Bool = false
    private var questionsAttempted: Int = 0
    private let speechGuide = SpeechGuide()

    init() {
        startNewSession()
    }

    func startNewSession() {
        speechGuide.stop()
        saveSessionIfNeeded()
        self.sessionToken = UUID()
        self.startTime = Date()
        self.hasSavedSession = false
        self.questionsAttempted = 0
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
        speechGuide.stop()

        guard currentRiddleIndex < riddles.count else {
            isCompleted = true
            feedbackMessage = "🎉 You solved all the Audio Riddles! Excellent listening!"
            speechGuide.speak("You solved all the Audio Riddles! Excellent listening!")
            saveSessionIfNeeded()
            return
        }

        let r = riddles[currentRiddleIndex]
        self.currentOptions = r.options.shuffled()
        self.selectedOptionID = nil
        self.isCorrectFeedback = false
        self.isIncorrectFeedback = false
        self.hasAttemptedCurrent = false
        self.feedbackMessage = "Listen to the clue: \"\(r.clueText)\""

        // Speak audioTranscript automatically upon loading riddle
        speechGuide.speak(r.audioTranscript)
    }

    var currentRiddle: AudioRiddle? {
        guard currentRiddleIndex < riddles.count else { return nil }
        return riddles[currentRiddleIndex]
    }

    func tapOption(_ option: AudioRiddleOption) {
        if isCorrectFeedback || isCompleted { return }

        speechGuide.stop()
        selectedOptionID = option.id

        if option.isCorrect {
            isCorrectFeedback = true
            isIncorrectFeedback = false
            score += 1
            if !hasAttemptedCurrent {
                questionsAttempted += 1
                firstTryCount += 1
            }
            hasAttemptedCurrent = true
            feedbackMessage = "⭐ That's right! It's \(option.title)!"
            speechGuide.speak("That's right! It's \(option.title)!")
        } else {
            isIncorrectFeedback = true
            isCorrectFeedback = false
            if !hasAttemptedCurrent {
                questionsAttempted += 1
                hintsCount += 1
            }
            hasAttemptedCurrent = true
            if let hint = currentRiddle?.hintText {
                feedbackMessage = "Try again! Hint: \(hint)"
                speechGuide.speak("Not quite! Try again.")
            } else {
                feedbackMessage = "Not quite! Listen closely and try another picture."
                speechGuide.speak("Not quite! Try again.")
            }
        }
    }

    func nextRiddle() {
        speechGuide.stop()
        if currentRiddleIndex + 1 < riddles.count {
            currentRiddleIndex += 1
            loadCurrentRiddle()
        } else {
            isCompleted = true
            feedbackMessage = "🎉 You solved all the Audio Riddles! Fantastic job!"
            speechGuide.speak("You solved all the Audio Riddles! Fantastic job!")
            saveSessionIfNeeded()
        }
    }

    func playAudioPrompt() {
        speechGuide.stop()
        if let transcript = currentRiddle?.audioTranscript {
            feedbackMessage = "🔊 Listening: \"\(transcript)\""
            speechGuide.speak(transcript)
        }
    }

    func stopSpeech() {
        speechGuide.stop()
        saveSessionIfNeeded()
    }

    func saveSessionIfNeeded() {
        guard !hasSavedSession else { return }
        guard questionsAttempted > 0 else { return }

        hasSavedSession = true
        let duration = max(1, Int(Date().timeIntervalSince(startTime)))
        let record = AudioRiddleRecord(
            id: sessionToken,
            date: Date(),
            totalQuestions: questionsAttempted,
            firstTryCorrect: firstTryCount,
            hintsUsed: hintsCount,
            durationSeconds: duration
        )
        AudioRiddleProgressStore.shared.add(record)
    }
}
