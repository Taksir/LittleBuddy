import Foundation
import SwiftUI

@MainActor
final class StoryProgressStore: ObservableObject {
    @Published private(set) var sessions: [StorySessionRecord] = []

    private let storageKey = "askAndFind.playground.storySessions.v1"

    init() {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let decoded = try? JSONDecoder().decode([StorySessionRecord].self, from: data)
        else {
            return
        }
        sessions = decoded.sorted { $0.startedAt > $1.startedAt }
    }

    func add(_ record: StorySessionRecord) {
        sessions.insert(record, at: 0)
        if sessions.count > 300 {
            sessions.removeLast(sessions.count - 300)
        }
        save()
    }

    func reset() {
        sessions = []
        UserDefaults.standard.removeObject(forKey: storageKey)
    }

    var totalStarted: Int { sessions.count }
    var totalCompleted: Int { sessions.filter { $0.storyCompleted }.count }
    var totalReviews: Int { sessions.filter { $0.reviewCompleted }.count }
    var totalQuestions: Int { sessions.reduce(0) { $0 + $1.questionsPresented } }
    var totalFirstTryCorrect: Int { sessions.reduce(0) { $0 + $1.firstTryCorrect } }
    var totalCorrected: Int { sessions.reduce(0) { $0 + $1.correctedAfterHelp } }
    var totalSeconds: Int { sessions.reduce(0) { $0 + $1.durationSeconds } }

    var firstTryRate: Double? {
        totalQuestions == 0 ? nil : Double(totalFirstTryCorrect) / Double(totalQuestions)
    }

    var correctionRate: Double? {
        totalQuestions == 0 ? nil : Double(totalCorrected) / Double(totalQuestions)
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(sessions) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
