import Foundation
import Observation

enum GameplayPhase: Equatable {
    case loading
    case asking
    case awaitingTap
    case respondingToMiss
    case showingHint
    case celebrating
    case demonstrating
    case completed
    case failedSafe(String)
}

@Observable
@MainActor
final class GameplayEngine {
    let scene: StoryScene
    let contentVersion: String
    let sessionID: UUID
    let selectedTargets: [HiddenTarget]
    let hintAfterMisses: Int
    let demonstrateAfterMisses: Int

    private let audio: AudioGuidance
    private let progress: ProgressRepository
    private var transitionTask: Task<Void, Never>?
    private var roundStartedAt: Date = .now

    private(set) var phase: GameplayPhase = .loading
    private(set) var currentIndex = 0
    private(set) var missCount = 0
    private(set) var feedbackText = ""
    private(set) var foundTargetID: String?

    var currentTarget: HiddenTarget? {
        selectedTargets.indices.contains(currentIndex) ? selectedTargets[currentIndex] : nil
    }

    var progressText: String {
        "Picture \(currentIndex + 1) of \(selectedTargets.count)"
    }

    init(scene: StoryScene, pack: ContentPack, targetLimit: Int, seed: UInt64, audio: AudioGuidance, progress: ProgressRepository) {
        self.scene = scene
        contentVersion = pack.contentVersion
        sessionID = UUID()
        selectedTargets = TargetSelector.select(from: scene.targets, limit: targetLimit, seed: seed)
        hintAfterMisses = pack.defaults.visualHintAfterMisses
        demonstrateAfterMisses = pack.defaults.demonstrateAfterMisses
        self.audio = audio
        self.progress = progress
    }

    deinit { transitionTask?.cancel() }

    func start() {
        guard !selectedTargets.isEmpty else {
            phase = .failedSafe("This picture needs a quick grown-up fix.")
            return
        }
        record(.sessionStarted)
        feedbackText = "Let’s look carefully together."
        audio.speak(feedbackText)
        schedule(afterNanoseconds: 1_100_000_000) { [weak self] in self?.askCurrentTarget() }
    }

    func replayInstruction() {
        guard let currentTarget else { return }
        audio.speak(currentTarget.question)
        record(.promptPlayed)
    }

    func handleTap(_ point: NormalizedPoint) {
        guard phase == .awaitingTap || phase == .showingHint, let target = currentTarget else { return }
        transitionTask?.cancel()
        if target.geometry.contains(point) {
            completeCurrentTarget(outcome: missCount >= hintAfterMisses ? .assisted : .independent)
        } else {
            handleMiss(for: target)
        }
    }

    func endSessionIfNeeded() {
        transitionTask?.cancel()
        audio.stop()
        guard phase != .completed else { return }
        record(.sessionEnded, outcome: .abandoned)
    }

    private func askCurrentTarget() {
        guard let currentTarget else { completeSession(); return }
        missCount = 0
        foundTargetID = nil
        roundStartedAt = .now
        phase = .asking
        feedbackText = ""
        audio.speak(currentTarget.question)
        record(.promptPlayed)
        schedule(afterNanoseconds: 450_000_000) { [weak self] in self?.phase = .awaitingTap }
    }

    private func handleMiss(for target: HiddenTarget) {
        missCount += 1
        record(.attempt, targetID: target.id, attemptNumber: missCount, outcome: .miss)
        if missCount >= demonstrateAfterMisses {
            phase = .demonstrating
            feedbackText = "This is the \(target.label). Let’s find another one."
            audio.speak(feedbackText)
            record(.targetDemonstrated, targetID: target.id, attemptNumber: missCount, outcome: .demonstrated)
            schedule(afterNanoseconds: 1_700_000_000) { [weak self] in self?.advance() }
        } else if missCount == hintAfterMisses {
            phase = .showingHint
            feedbackText = "Let me help. Watch here."
            audio.speak(feedbackText)
            record(.hintShown, targetID: target.id, attemptNumber: missCount)
        } else {
            phase = .respondingToMiss
            feedbackText = missCount == 1 ? "Good looking. Try again." : "Take your time. Look all around."
            audio.speak(feedbackText)
            schedule(afterNanoseconds: 850_000_000) { [weak self] in self?.phase = .awaitingTap }
        }
    }

    private func completeCurrentTarget(outcome: LearningOutcome) {
        guard let target = currentTarget else { return }
        phase = .celebrating
        foundTargetID = target.id
        feedbackText = outcome == .independent ? target.successLine : "That’s the \(target.label). Nice finding."
        audio.speak(feedbackText)
        record(.attempt, targetID: target.id, attemptNumber: missCount + 1, outcome: .hit)
        record(.targetCompleted, targetID: target.id, attemptNumber: missCount, outcome: outcome)
        schedule(afterNanoseconds: 1_200_000_000) { [weak self] in self?.advance() }
    }

    private func advance() {
        currentIndex += 1
        if currentIndex == selectedTargets.count { completeSession() } else { askCurrentTarget() }
    }

    private func completeSession() {
        transitionTask?.cancel()
        phase = .completed
        feedbackText = "You looked so carefully. We found them all!"
        audio.speak(feedbackText)
        record(.sessionEnded, activeDurationMs: Int(Date.now.timeIntervalSince(roundStartedAt) * 1_000))
    }

    private func record(_ type: LearningEventType, targetID: String? = nil, attemptNumber: Int? = nil, outcome: LearningOutcome? = nil, activeDurationMs: Int? = nil) {
        do {
            try progress.append(LearningEvent(
                sessionID: sessionID,
                sceneID: scene.id,
                targetID: targetID,
                eventType: type,
                attemptNumber: attemptNumber,
                outcome: outcome,
                activeDurationMs: activeDurationMs,
                contentVersion: contentVersion
            ))
        } catch {
            phase = .failedSafe("We can still play, but progress could not be saved.")
        }
    }

    private func schedule(afterNanoseconds delay: UInt64, action: @escaping @MainActor () -> Void) {
        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: delay)
            guard !Task.isCancelled else { return }
            action()
        }
    }
}
