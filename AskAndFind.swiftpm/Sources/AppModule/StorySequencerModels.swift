import Foundation

struct SequencerCard: Identifiable, Equatable, Hashable {
    let id: String
    let pageOrder: Int // 1-indexed true chronological order
    let pageTitle: String
    let imageAsset: String
    let narrationSnippet: String
    let altText: String
}

enum SequencerSlotState: Equatable {
    case empty
    case filled(SequencerCard)
    case correct(SequencerCard)
    case incorrect(SequencerCard)
}

struct StorySequencerRecord: Codable, Identifiable {
    let id: UUID
    let storyID: String
    let level: Int
    let date: Date
    let attempts: Int
    let hintsUsed: Int
    let completedSuccessfully: Bool
    let durationSeconds: Int
}
