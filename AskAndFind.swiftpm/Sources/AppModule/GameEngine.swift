import Foundation

@MainActor
final class GameEngine: ObservableObject {
    let scene: StoryScene
    let targets: [HiddenTarget]

    @Published private(set) var phase: GameplayPhase = .ready
    @Published private(set) var currentIndex = 0
    @Published private(set) var misses = 0
    @Published private(set) var feedback = ""
    @Published private(set) var highlightedTargetID: String?

    private let progress: ProgressStore
    private let speech = SpeechGuide()
    private let sessionID = UUID()
    private let startedAt = Date()
    private var transition: DispatchWorkItem?
    private var didSave = false
    private var completedCount = 0
    private var independentCount = 0
    private var hintCount = 0
    private var tapCount = 0

    var currentTarget: HiddenTarget? {
        targets.indices.contains(currentIndex) ? targets[currentIndex] : nil
    }

    var progressText: String {
        "Object \(min(currentIndex + 1, targets.count)) of \(targets.count)"
    }

    init(scene: StoryScene, targetLimit: Int, progress: ProgressStore) {
        self.scene = scene
        targets = SceneCatalog.selectTargets(from: scene, limit: targetLimit)
        self.progress = progress
    }

    func start() {
        guard phase == .ready else { return }
        feedback = "Let’s look carefully together."
        speech.speak(feedback)
        schedule(after: 1.0) { [weak self] in self?.askCurrentTarget() }
    }

    func replay() {
        guard let currentTarget, phase != .completed else { return }
        speech.speak(currentTarget.question)
    }

    func handleTap(_ point: NormalizedPoint) {
        guard phase == .awaitingTap || phase == .showingHint, let target = currentTarget else { return }
        transition?.cancel()
        tapCount += 1
        if target.box.contains(point) {
            completeTarget(target)
        } else {
            handleMiss(target)
        }
    }

    func stopAndSave() {
        transition?.cancel()
        speech.stop()
        saveSessionIfNeeded()
    }

    private func askCurrentTarget() {
        guard let target = currentTarget else { completeSession(); return }
        misses = 0
        highlightedTargetID = nil
        feedback = ""
        phase = .asking
        speech.speak(target.question)
        schedule(after: 0.45) { [weak self] in self?.phase = .awaitingTap }
    }

    private func handleMiss(_ target: HiddenTarget) {
        misses += 1
        if misses >= 5 {
            phase = .demonstrating
            highlightedTargetID = target.id
            completedCount += 1
            feedback = "This is the \(target.label). Let’s find another one."
            speech.speak(feedback)
            schedule(after: 1.7) { [weak self] in self?.advance() }
        } else if misses == 3 {
            phase = .showingHint
            highlightedTargetID = target.id
            hintCount += 1
            feedback = "Let me help. Watch here."
            speech.speak(feedback)
        } else {
            phase = .respondingToMiss
            feedback = misses == 1 ? "Good looking. Try again." : "Take your time. Look all around."
            speech.speak(feedback)
            schedule(after: 0.8) { [weak self] in self?.phase = .awaitingTap }
        }
    }

    private func completeTarget(_ target: HiddenTarget) {
        completedCount += 1
        if misses < 3 { independentCount += 1 }
        phase = .celebrating
        highlightedTargetID = target.id
        feedback = misses < 3 ? target.successLine : "That’s the \(target.label). Nice finding."
        speech.speak(feedback)
        schedule(after: 1.2) { [weak self] in self?.advance() }
    }

    private func advance() {
        currentIndex += 1
        currentIndex >= targets.count ? completeSession() : askCurrentTarget()
    }

    private func completeSession() {
        phase = .completed
        highlightedTargetID = nil
        feedback = "You looked so carefully. We found them all!"
        speech.speak(feedback)
        saveSessionIfNeeded()
    }

    private func saveSessionIfNeeded() {
        guard !didSave else { return }
        didSave = true
        progress.add(SessionRecord(
            id: sessionID,
            date: startedAt,
            sceneID: scene.id,
            selectedTargets: targets.count,
            completedTargets: completedCount,
            independentTargets: independentCount,
            hintsUsed: hintCount,
            tapAttempts: tapCount,
            durationSeconds: max(1, Int(Date().timeIntervalSince(startedAt)))
        ))
    }

    private func schedule(after delay: TimeInterval, action: @escaping @MainActor () -> Void) {
        transition?.cancel()
        let item = DispatchWorkItem { Task { @MainActor in action() } }
        transition = item
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: item)
    }
}
