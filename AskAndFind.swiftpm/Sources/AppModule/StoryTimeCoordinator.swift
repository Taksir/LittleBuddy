import Foundation
import SwiftUI

@MainActor
final class StoryTimeCoordinator: ObservableObject {
    let book: StoryBook

    @Published private(set) var phase: StoryTimePhase = .cover
    @Published private(set) var pageIndex = 0
    @Published private(set) var questionIndex = 0
    @Published private(set) var selectedChoiceID: String?
    @Published private(set) var correctChoiceID: String?
    @Published private(set) var feedback = ""
    @Published private(set) var wrongAttempts = 0
    @Published private(set) var narrationReplayCount = 0

    private let progress: StoryProgressStore
    private let speech = SpeechGuide()
    private var sessionID = UUID()
    private var startedAt = Date()
    private var transition: DispatchWorkItem?
    private var didSave = false
    private var storyCompleted = false
    private var reviewCompleted = false
    private var questionsPresented = 0
    private var firstTryCorrect = 0
    private var correctedAfterHelp = 0
    private var didAttemptCurrentQuestion = false

    init(book: StoryBook, progress: StoryProgressStore) {
        self.book = book
        self.progress = progress
    }

    var currentPage: StoryPage {
        book.pages[pageIndex]
    }

    var currentQuestion: StoryQuestion {
        book.questions[questionIndex]
    }

    var canGoBack: Bool {
        phase == .reading && pageIndex > 0
    }

    func startReading() {
        guard phase == .cover else { return }
        pageIndex = 0
        phase = .reading
        speakCurrentPage(after: 0.25)
    }

    func startAgain() {
        transition?.cancel()
        speech.stop()
        sessionID = UUID()
        startedAt = Date()
        didSave = false
        storyCompleted = false
        reviewCompleted = false
        questionsPresented = 0
        firstTryCorrect = 0
        correctedAfterHelp = 0
        narrationReplayCount = 0
        pageIndex = 0
        questionIndex = 0
        selectedChoiceID = nil
        correctChoiceID = nil
        wrongAttempts = 0
        feedback = ""
        didAttemptCurrentQuestion = false
        phase = .reading
        speakCurrentPage(after: 0.25)
    }

    func goBack() {
        guard canGoBack else { return }
        pageIndex -= 1
        speakCurrentPage(after: 0.25)
    }

    func goForward() {
        guard phase == .reading else { return }
        if pageIndex < book.pages.count - 1 {
            pageIndex += 1
            speakCurrentPage(after: 0.25)
        } else {
            finishStory()
        }
    }

    func replayCurrentPage() {
        guard phase == .reading else { return }
        narrationReplayCount += 1
        speech.speak(currentPage.narrationTranscript)
    }

    func finishStory() {
        guard phase == .reading, pageIndex == book.pages.count - 1 else { return }
        transition?.cancel()
        speech.stop()
        storyCompleted = true
        phase = .storyComplete
        feedback = "You listened to the whole story."
        speech.speak(feedback)
    }

    func beginReview() {
        guard phase == .storyComplete else { return }
        transition?.cancel()
        questionIndex = 0
        selectedChoiceID = nil
        correctChoiceID = nil
        wrongAttempts = 0
        feedback = ""
        phase = .reviewIntro
        speech.speak("Let's think about the story together.")
        schedule(after: 1.1) { [weak self] in
            self?.askCurrentQuestion()
        }
    }

    func replayQuestion() {
        guard phase == .reviewQuestion || phase == .reviewCorrection else { return }
        speech.speak(questionAudio)
    }

    func choose(_ choice: StoryChoice) {
        guard phase == .reviewQuestion || phase == .reviewCorrection else { return }

        selectedChoiceID = choice.id
        let question = currentQuestion
        let correctID = question.choices.first(where: { $0.isCorrect })?.id
        let isCorrect = choice.id == correctID

        if isCorrect {
            if !didAttemptCurrentQuestion {
                firstTryCorrect += 1
            } else {
                correctedAfterHelp += 1
            }
            didAttemptCurrentQuestion = true
            correctChoiceID = choice.id
            feedback = question.correctResponse
            phase = .reviewFeedback
            speech.speak(question.correctResponse)
        } else {
            wrongAttempts += 1
            didAttemptCurrentQuestion = true
            correctChoiceID = correctID
            feedback = question.correctionResponse
            speech.speak(question.correctionResponse)
            phase = wrongAttempts >= 2 ? .reviewFeedback : .reviewCorrection
        }
    }

    func continueReview() {
        guard phase == .reviewFeedback else { return }

        if questionIndex < book.questions.count - 1 {
            questionIndex += 1
            askCurrentQuestion()
        } else {
            completeReview()
        }
    }

    func stopAndSave() {
        transition?.cancel()
        speech.stop()
        saveSessionIfNeeded()
    }

    private var questionAudio: String {
        let choices = currentQuestion.choices.map(\.label).joined(separator: ", or ")
        return "\(currentQuestion.prompt) \(choices)."
    }

    private func speakCurrentPage(after delay: TimeInterval) {
        transition?.cancel()
        speech.stop()
        let item = DispatchWorkItem { [weak self] in
            guard let self else { return }
            self.speech.speak(self.currentPage.narrationTranscript)
        }
        transition = item
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: item)
    }

    private func askCurrentQuestion() {
        transition?.cancel()
        selectedChoiceID = nil
        correctChoiceID = nil
        wrongAttempts = 0
        didAttemptCurrentQuestion = false
        questionsPresented = max(questionsPresented, questionIndex + 1)
        phase = .reviewQuestion
        speech.speak(questionAudio)
    }

    private func completeReview() {
        reviewCompleted = true
        phase = .reviewComplete
        feedback = "You remembered the story so carefully."
        speech.speak(feedback)
        saveSessionIfNeeded()
    }

    private func saveSessionIfNeeded() {
        guard !didSave else { return }
        didSave = true
        progress.add(
            StorySessionRecord(
                id: sessionID,
                storyID: book.id,
                contentVersion: book.contentVersion,
                startedAt: startedAt,
                endedAt: Date(),
                lastPageIndex: pageIndex,
                storyCompleted: storyCompleted,
                narrationReplayCount: narrationReplayCount,
                reviewCompleted: reviewCompleted,
                questionsPresented: questionsPresented,
                firstTryCorrect: firstTryCorrect,
                correctedAfterHelp: correctedAfterHelp,
                durationSeconds: max(1, Int(Date().timeIntervalSince(startedAt)))
            )
        )
    }

    private func schedule(after delay: TimeInterval, action: @escaping @MainActor () -> Void) {
        transition?.cancel()
        let item = DispatchWorkItem {
            Task { @MainActor in action() }
        }
        transition = item
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: item)
    }
}
