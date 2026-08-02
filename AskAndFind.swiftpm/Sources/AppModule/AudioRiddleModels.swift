import Foundation

struct AudioRiddleOption: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let storyID: String
    let assetVersion: String
    let imageAsset: String
    let isCorrect: Bool
}

struct AudioRiddle: Identifiable, Equatable, Hashable {
    let id: String
    let prompt: String
    let clueText: String
    let audioTranscript: String
    let options: [AudioRiddleOption]
    let hintText: String
}

struct AudioRiddleRecord: Codable, Identifiable {
    let id: UUID
    let date: Date
    let totalQuestions: Int
    let firstTryCorrect: Int
    let hintsUsed: Int
    let durationSeconds: Int
}
