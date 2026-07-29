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

    static let empty = ParentSummary(sessionCount: 0, activePlaySeconds: 0, targetsAttempted: 0, targetsCompleted: 0, firstTryRate: nil, independentSuccessRate: nil, assistedSuccessRate: nil, hintRate: nil, averageAttempts: nil, recentSessions: [])
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
        let prompts = scoped.filter { $0.eventType == .promptPlayed }
        let completed = scoped.filter { $0.eventType == .targetCompleted || $0.eventType == .targetDemonstrated }
        let independent = completed.filter { $0.outcome == .independent }
        let assisted = completed.filter { $0.outcome == .assisted }
        let hints = scoped.filter { $0.eventType == .hintShown }
        let attempts = scoped.filter { $0.eventType == .attempt }
        let activeMilliseconds = scoped.compactMap { $0.activeDurationMs }.reduce(0, +)

        let firstTry = independent.filter { completion in
            !scoped.contains { event in
                event.sessionID == completion.sessionID && event.targetID == completion.targetID && event.eventType == .attempt && event.outcome == .miss
            }
        }

        let grouped = Dictionary(grouping: scoped) { $0.sessionID }
        let sessions = grouped.compactMap { sessionID, sessionEvents -> ParentSessionSummary? in
            guard let started = sessionEvents.first(where: { $0.eventType == .sessionStarted }) else { return nil }
            let targetCount = sessionEvents.filter { $0.eventType == .targetCompleted || $0.eventType == .targetDemonstrated }.count
            let hintCount = sessionEvents.filter { $0.eventType == .hintShown }.count
            let seconds = sessionEvents.compactMap { $0.activeDurationMs }.reduce(0, +) / 1_000
            return ParentSessionSummary(id: sessionID, date: started.occurredAt, sceneID: started.sceneID, completedTargets: targetCount, hintsUsed: hintCount, activeSeconds: seconds)
        }.sorted { $0.date > $1.date }

        let denominator = completed.count
        return ParentSummary(
            sessionCount: sessionStarts.count,
            activePlaySeconds: activeMilliseconds / 1_000,
            targetsAttempted: prompts.count,
            targetsCompleted: denominator,
            firstTryRate: denominator == 0 ? nil : Double(firstTry.count) / Double(denominator),
            independentSuccessRate: denominator == 0 ? nil : Double(independent.count) / Double(denominator),
            assistedSuccessRate: denominator == 0 ? nil : Double(assisted.count) / Double(denominator),
            hintRate: denominator == 0 ? nil : Double(hints.count) / Double(denominator),
            averageAttempts: denominator == 0 ? nil : Double(attempts.count) / Double(denominator),
            recentSessions: Array(sessions.prefix(8))
        )
    }
}
