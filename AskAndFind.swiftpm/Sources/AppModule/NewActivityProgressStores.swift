import Foundation
import SwiftUI

// MARK: - Audio Riddle Progress Store
@MainActor
final class AudioRiddleProgressStore: ObservableObject {
    static let shared = AudioRiddleProgressStore()

    @Published private(set) var sessions: [AudioRiddleRecord] = []
    private let storageKey = "askAndFind.playground.audioRiddleSessions.v1"

    init() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([AudioRiddleRecord].self, from: data) else { return }
        sessions = decoded.sorted { $0.date > $1.date }
    }

    func add(_ record: AudioRiddleRecord) {
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

    var totalSessions: Int { sessions.count }
    var totalQuestionsAttempted: Int { sessions.reduce(0) { $0 + $1.totalQuestions } }
    var totalFirstTryCorrect: Int { sessions.reduce(0) { $0 + $1.firstTryCorrect } }
    var totalHintsUsed: Int { sessions.reduce(0) { $0 + $1.hintsUsed } }
    var totalSeconds: Int { sessions.reduce(0) { $0 + $1.durationSeconds } }

    var firstTryRate: Double? {
        totalQuestionsAttempted == 0 ? nil : Double(totalFirstTryCorrect) / Double(totalQuestionsAttempted)
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(sessions) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}

// MARK: - Story Sequencer Progress Store
@MainActor
final class StorySequencerProgressStore: ObservableObject {
    static let shared = StorySequencerProgressStore()

    @Published private(set) var sessions: [StorySequencerRecord] = []
    private let storageKey = "askAndFind.playground.storySequencerSessions.v1"

    init() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([StorySequencerRecord].self, from: data) else { return }
        sessions = decoded.sorted { $0.date > $1.date }
    }

    func add(_ record: StorySequencerRecord) {
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

    var totalSessions: Int { sessions.count }
    var totalCompleted: Int { sessions.filter { $0.completedSuccessfully }.count }
    var totalAttempts: Int { sessions.reduce(0) { $0 + $1.attempts } }
    var totalHints: Int { sessions.reduce(0) { $0 + $1.hintsUsed } }
    var totalSeconds: Int { sessions.reduce(0) { $0 + $1.durationSeconds } }

    var completionRate: Double? {
        totalSessions == 0 ? nil : Double(totalCompleted) / Double(totalSessions)
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(sessions) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
