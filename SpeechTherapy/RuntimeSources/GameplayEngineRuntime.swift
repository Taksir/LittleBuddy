import Foundation
import Observation

enum GameplayPhase: Equatable {
    case loading, asking, awaitingTap, respondingToMiss, showingHint, celebrating, demonstrating, completed
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
    private var sessionStartedAt: Date?

    private(set) var phase: GameplayPhase = .loading
    private(set) var currentIndex = 0
    private(set) var missCount = 0
    private(set) var feedbackText = ""
    private(set) var foundTargetID: String?

    var currentTarget: HiddenTarget? { selectedTargets.indices.contains(currentIndex) ? selectedTargets[currentIndex] : nil }
    var progressText: String { "Picture \(min(currentIndex + 1, selectedTargets.count)) of \(selectedTargets.count)" }

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
        guard phase == .loading else { return }
        guard !selectedTargets.isEmpty else {
            phase = .failedSafe("This picture needs a quick grown-up fix.")
            return
        }
        sessionStartedAt = .now
        record(.sessionStarted)
        feedbackText = "Let’s look carefully together."
        audio.speak(feedbackText)
        schedule(after: 1.1) { [weak self] in self?.askCurrentTarget() }
    }

    func replayInstruction() {
        guard let currentTarget, phase != .completed else { return }
        audio.speak(currentTarget.question)
        record(.promptPlayed, targetID: currentTarget.id)
    }

    func handleTap(_ point: NormalizedPoint) {
        guard phase == .awaitingTap || phase == .showingHint, let target = currentTarget else { return }
        transitionTask?.cancel()
        target.geometry.contains(point) ? completeCurrentTarget(outcome: missCount >= hintAfterMisses ? .assisted : .independent) : handleMiss(for: target)
    }

    func endSessionIfNeeded() {
        transitionTask?.cancel()
        audio.stop()
        guard phase != .completed, sessionStartedAt != nil else { return }
        record(.sessionEnded, outcome: .abandoned, activeDurationMs: activeDurationMilliseconds)
        sessionStartedAt = nil
    }

    private func askCurrentTarget() {
        guard let currentTarget else { completeSession(); return }
        missCount = 0
        foundTargetID = nil
        phase = .asking
        feedbackText = ""
        audio.speak(currentTarget.question)
        record(.promptPlayed, targetID: currentTarget.id)
        schedule(after: 0.45) { [weak self] in self?.phase = .awaitingTap }
    }

    private func handleMiss(for target: HiddenTarget) {
        missCount += 1
        record(.attempt, targetID: target.id, attemptNumber: missCount, outcome: .miss)
        if missCount >= demonstrateAfterMisses {
            phase = .demonstrating
            feedbackText = "This is the \(target.label). Let’s find another one."
            audio.speak(feedbackText)
            record(.targetDemonstrated, targetID: target.id, attemptNumber: missCount, outcome: .demonstrated)
            schedule(after: 1.7) { [weak self] in self?.advance() }
        } else if missCount == hintAfterMisses {
            phase = .showingHint
            feedbackText = "Let me help. Watch here."
            audio.speak(feedbackText)
            record(.hintShown, targetID: target.id, attemptNumber: missCount)
        } else {
            phase = .respondingToMiss
            feedbackText = missCount == 1 ? "Good looking. Try again." : "Take your time. Look all around."
            audio.speak(feedbackText)
            schedule(after: 0.85) { [weak self] in self?.phase = .awaitingTap }
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
        schedule(after: 1.2) { [weak self] in self?.advance() }
    }

    private func advance() {
        currentIndex += 1
        currentIndex == selectedTargets.count ? completeSession() : askCurrentTarget()
    }

    private func completeSession() {
        transitionTask?.cancel()
        phase = .completed
        feedbackText = "You looked so carefully. We found them all!"
        audio.speak(feedbackText)
        record(.sessionEnded, activeDurationMs: activeDurationMilliseconds)
        sessionStartedAt = nil
    }

    private var activeDurationMilliseconds: Int? {
        guard let sessionStartedAt else { return nil }
        return Int(Date.now.timeIntervalSince(sessionStartedAt) * 1_000)
    }

    private func record(_ type: LearningEventType, targetID: String? = nil, attemptNumber: Int? = nil, outcome: LearningOutcome? = nil, activeDurationMs: Int? = nil) {
        do {
            try progress.append(LearningEvent(sessionID: sessionID, sceneID: scene.id, targetID: targetID, eventType: type, attemptNumber: attemptNumber, outcome: outcome, activeDurationMs: activeDurationMs, contentVersion: contentVersion))
        } catch {
            feedbackText = "We can still play. Progress may not save this time."
        }
    }

    private func schedule(after seconds: TimeInterval, action: @escaping @MainActor () -> Void) {
        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(seconds))
            guard !Task.isCancelled else { return }
            action()
        }
    }
}
