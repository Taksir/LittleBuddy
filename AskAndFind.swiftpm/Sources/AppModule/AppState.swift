import Foundation
import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var route: AppRoute = .home
    @Published var promptTextEnabled: Bool {
        didSet { UserDefaults.standard.set(promptTextEnabled, forKey: "playground.promptText") }
    }
    @Published var reducedMovement: Bool {
        didSet { UserDefaults.standard.set(reducedMovement, forKey: "playground.reducedMovement") }
    }
    @Published var targetLimit: Int {
        didSet { UserDefaults.standard.set(targetLimit, forKey: "playground.targetLimit") }
    }

    init() {
        promptTextEnabled = UserDefaults.standard.bool(forKey: "playground.promptText")
        reducedMovement = UserDefaults.standard.bool(forKey: "playground.reducedMovement")
        let savedLimit = UserDefaults.standard.integer(forKey: "playground.targetLimit")
        targetLimit = (3...5).contains(savedLimit) ? savedLimit : 5
    }

    func beginGame() {
        route = .play(UUID())
    }
}

struct SessionRecord: Codable, Identifiable {
    let id: UUID
    let date: Date
    let sceneID: String
    let selectedTargets: Int
    let completedTargets: Int
    let independentTargets: Int
    let hintsUsed: Int
    let tapAttempts: Int
    let durationSeconds: Int
}

@MainActor
final class ProgressStore: ObservableObject {
    @Published private(set) var sessions: [SessionRecord] = []
    private let storageKey = "askAndFind.playground.sessions.v1"

    init() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([SessionRecord].self, from: data) else { return }
        sessions = decoded.sorted { $0.date > $1.date }
    }

    func add(_ session: SessionRecord) {
        sessions.insert(session, at: 0)
        if sessions.count > 300 { sessions.removeLast(sessions.count - 300) }
        save()
    }

    func reset() {
        sessions = []
        UserDefaults.standard.removeObject(forKey: storageKey)
    }

    var totalCompleted: Int { sessions.reduce(0) { $0 + $1.completedTargets } }
    var totalHints: Int { sessions.reduce(0) { $0 + $1.hintsUsed } }
    var totalSeconds: Int { sessions.reduce(0) { $0 + $1.durationSeconds } }
    var totalAttempts: Int { sessions.reduce(0) { $0 + $1.tapAttempts } }
    var totalIndependent: Int { sessions.reduce(0) { $0 + $1.independentTargets } }

    var independentRate: Double? {
        totalCompleted == 0 ? nil : Double(totalIndependent) / Double(totalCompleted)
    }

    var hintRate: Double? {
        totalCompleted == 0 ? nil : Double(totalHints) / Double(totalCompleted)
    }

    var averageAttempts: Double? {
        totalCompleted == 0 ? nil : Double(totalAttempts) / Double(totalCompleted)
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(sessions) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
