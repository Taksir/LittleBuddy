import Foundation
import SwiftData

enum LearningEventType: String, Codable, CaseIterable {
    case sessionStarted
    case promptPlayed
    case attempt
    case hintShown
    case targetCompleted
    case targetDemonstrated
    case sessionEnded
}

enum LearningOutcome: String, Codable {
    case hit, miss, independent, assisted, demonstrated, abandoned
}

struct LearningEvent: Identifiable, Equatable {
    let id: UUID
    let occurredAt: Date
    let sessionID: UUID
    let activityID: String
    let sceneID: String
    let targetID: String?
    let eventType: LearningEventType
    let attemptNumber: Int?
    let outcome: LearningOutcome?
    let activeDurationMs: Int?
    let contentVersion: String

    init(id: UUID = UUID(), occurredAt: Date = .now, sessionID: UUID, activityID: String = "hidden-objects", sceneID: String, targetID: String? = nil, eventType: LearningEventType, attemptNumber: Int? = nil, outcome: LearningOutcome? = nil, activeDurationMs: Int? = nil, contentVersion: String) {
        self.id = id
        self.occurredAt = occurredAt
        self.sessionID = sessionID
        self.activityID = activityID
        self.sceneID = sceneID
        self.targetID = targetID
        self.eventType = eventType
        self.attemptNumber = attemptNumber
        self.outcome = outcome
        self.activeDurationMs = activeDurationMs
        self.contentVersion = contentVersion
    }
}

@Model
final class LearningEventRecord {
    @Attribute(.unique) var id: UUID
    var occurredAt: Date
    var sessionID: UUID
    var activityID: String
    var sceneID: String
    var targetID: String?
    var eventTypeRaw: String
    var attemptNumber: Int?
    var outcomeRaw: String?
    var activeDurationMs: Int?
    var contentVersion: String

    init(event: LearningEvent) {
        id = event.id
        occurredAt = event.occurredAt
        sessionID = event.sessionID
        activityID = event.activityID
        sceneID = event.sceneID
        targetID = event.targetID
        eventTypeRaw = event.eventType.rawValue
        attemptNumber = event.attemptNumber
        outcomeRaw = event.outcome?.rawValue
        activeDurationMs = event.activeDurationMs
        contentVersion = event.contentVersion
    }

    var event: LearningEvent? {
        guard let eventType = LearningEventType(rawValue: eventTypeRaw) else { return nil }
        return LearningEvent(id: id, occurredAt: occurredAt, sessionID: sessionID, activityID: activityID, sceneID: sceneID, targetID: targetID, eventType: eventType, attemptNumber: attemptNumber, outcome: outcomeRaw.flatMap { LearningOutcome(rawValue: $0) }, activeDurationMs: activeDurationMs, contentVersion: contentVersion)
    }
}

@MainActor
protocol ProgressRepository {
    func append(_ event: LearningEvent) throws
    func allEvents() throws -> [LearningEvent]
    func resetAll() throws
}

@MainActor
final class SwiftDataProgressRepository: ProgressRepository {
    private let context: ModelContext

    init(context: ModelContext) { self.context = context }

    func append(_ event: LearningEvent) throws {
        context.insert(LearningEventRecord(event: event))
        try context.save()
    }

    func allEvents() throws -> [LearningEvent] {
        let records = try context.fetch(FetchDescriptor<LearningEventRecord>())
        return records.compactMap { $0.event }.sorted { $0.occurredAt < $1.occurredAt }
    }

    func resetAll() throws {
        for record in try context.fetch(FetchDescriptor<LearningEventRecord>()) { context.delete(record) }
        try context.save()
    }
}
