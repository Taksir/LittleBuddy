import XCTest
@testable import AskAndFind

final class AskAndFindTests: XCTestCase {
    func testDemoCatalogHasTenValidatedScenesAndTargets() throws {
        let pack = try BundledSceneCatalog.load()
        XCTAssertEqual(pack.scenes.count, 10)
        XCTAssertTrue(pack.scenes.allSatisfy { $0.targets.count == 10 })
    }

    func testSelectorIsDeterministicAndNeverSelectsMoreThanFive() {
        let candidates = DemoContent.pack.scenes[0].targets
        let first = TargetSelector.select(from: candidates, limit: 9, seed: 42)
        let second = TargetSelector.select(from: candidates, limit: 9, seed: 42)
        XCTAssertEqual(first, second)
        XCTAssertEqual(first.count, 5)
        XCTAssertEqual(Set(first.map(\.id)).count, 5)
    }

    func testExpandedHitGeometryAcceptsMotorFriendlyEdge() {
        let geometry = HitGeometry(bbox: NormalizedRect(x: 0.4, y: 0.4, width: 0.1, height: 0.1), touchExpansion: 0.02)
        XCTAssertTrue(geometry.contains(NormalizedPoint(x: 0.39, y: 0.45)))
        XCTAssertFalse(geometry.contains(NormalizedPoint(x: 0.30, y: 0.45)))
    }

    func testMetricsSeparateIndependentAndAssistedSuccess() {
        let session = UUID()
        let now = Date.now
        let events = [
            LearningEvent(occurredAt: now, sessionID: session, sceneID: "garden", eventType: .sessionStarted, contentVersion: "test"),
            LearningEvent(occurredAt: now, sessionID: session, sceneID: "garden", targetID: "bunny", eventType: .promptPlayed, contentVersion: "test"),
            LearningEvent(occurredAt: now, sessionID: session, sceneID: "garden", targetID: "bunny", eventType: .targetCompleted, outcome: .independent, contentVersion: "test"),
            LearningEvent(occurredAt: now, sessionID: session, sceneID: "garden", targetID: "hat", eventType: .promptPlayed, contentVersion: "test"),
            LearningEvent(occurredAt: now, sessionID: session, sceneID: "garden", targetID: "hat", eventType: .attempt, attemptNumber: 1, outcome: .miss, contentVersion: "test"),
            LearningEvent(occurredAt: now, sessionID: session, sceneID: "garden", targetID: "hat", eventType: .hintShown, attemptNumber: 3, contentVersion: "test"),
            LearningEvent(occurredAt: now, sessionID: session, sceneID: "garden", targetID: "hat", eventType: .targetCompleted, outcome: .assisted, contentVersion: "test")
        ]
        let summary = ParentMetricsCalculator.summary(events: events, since: now.addingTimeInterval(-1), now: now.addingTimeInterval(1))
        XCTAssertEqual(summary.sessionCount, 1)
        XCTAssertEqual(summary.targetsAttempted, 2)
        XCTAssertEqual(summary.targetsCompleted, 2)
        XCTAssertEqual(summary.firstTryRate, 0.5)
        XCTAssertEqual(summary.independentSuccessRate, 0.5)
        XCTAssertEqual(summary.assistedSuccessRate, 0.5)
        XCTAssertEqual(summary.hintRate, 0.5)
    }

}
