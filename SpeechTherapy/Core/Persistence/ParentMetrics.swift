import Foundation

struct ParentSummary: Equatable {
    let sessionCount: Int
    let activePlaySeconds: Int
    let targetsAttempted: Int
    let targetsCompleted: Int
    let firstTryRate: Double?
    let independentSuccessRate: Double?
    let assistedSuccessRate: Double?
    let hintRate: Double?
    let averageAttempts: Double?
    let recentSessions: [ParentSessionSummary]

    static let empty = ParentSummary(
        sessionCount: 0, activePlaySeconds: 0, targetsAttempted: 0, targetsCompleted: 0,
        firstTryRate: nil, independentSuccessRate: nil, assistedSuccessRate: nil,
        hintRate: nil, averageAttempts: nil, recentSessions: []
    )
}

struct ParentSessionSummary: Identifiable, Equatable {
    let id: UUID
    let date: Date
    let sceneID: String
    let completedTargets: Int
    let hintsUsed: Int
    let activeSeconds: Int
}

enum ParentMetricsCalculator {
    static func summary(events: [LearningEvent], since startDate: Date, now: Date = .now) -> ParentSummary {
        let scoped = events.filter { $0.occurredAt >= startDate && $0.occurredAt <= now }
        let sessionStarts = scoped.filter { $0.eventType == .sessionStarted }
        let completed = scoped.filter { $0.eventType == .targetCompleted || $0.eventType == .targetDemonstrated }
        let independent = completed.filter { $0.outcome == .independent }
        let assisted = completed.filter { $0.outcome == .assisted }
        let firstTry = independent.filter { event in
            let misses = scoped.filter {
                $0.sessionID == event.sessionID && $0.targetID == event.targetID && $0.eventType == .attempt && $0.outcome == .miss
            }
            return misses.isEmpty
        }
        let hints = scoped.filter { $0.eventType == .hintShown }
        let attempts = scoped.filter { $0.eventType == .attempt }
        let activeMs = scoped.compactMap(\\.activeDurationMs).reduce(0, +)

        let grouped = Dictionary(grouping: scoped, by: \\.sessionID)
        let sessionSummaries = grouped.compactMap { sessionID, sessionEvents -> ParentSessionSummary? in
            guard let started = sessionEvents.first(where: { $0.eventType == .sessionStarted }) else { return nil }
            let sessionCompleted = sessionEvents.filter { $0.eventType == .targetCompleted || $0.eventType == .targetDemonstrated }.count
            let sessionHints = sessionEvents.filter { $0.eventType == .hintShown }.count
            let seconds = sessionEvents.compactMap(\\.activeDurationMs).reduce(0, +) / 1_000
            return ParentSessionSummary(id: sessionID, date: started.occurredAt, sceneID: started.sceneID, completedTargets: sessionCompleted, hintsUsed: sessionHints, activeSeconds: seconds)
        }.sorted { $0.date > $1.date }

        let total = completed.count
        return ParentSummary(
            sessionCount: sessionStarts.count,
            activePlaySeconds: activeMs / 1_000,
            targetsAttempted: total,
            targetsCompleted: total,
            firstTryRate: total == 0 ? nil : Double(firstTry.count) / Double(total),
            independentSuccessRate: total == 0 ? nil : Double(independent.count) / Double(total),
            assistedSuccessRate: total == 0 ? nil : Double(assisted.count) / Double(total),
            hintRate: total == 0 ? nil : Double(hints.count) / Double(total),
            averageAttempts: total == 0 ? nil : Double(attempts.count) / Double(total),
            recentSessions: Array(sessionSummaries.prefix(8))
        )
    }
}
