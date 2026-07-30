import Foundation

enum StoryArtKind: String, Codable, Hashable {
    case ranch
    case emptyGrass
    case ranchers
    case warning
    case tiger
    case distantCall
    case quietField
    case tracks
    case sunrise
}

struct StoryPage: Identifiable, Codable, Hashable {
    let id: String
    let order: Int
    let imageAsset: String
    let displayedText: String
    let narrationTranscript: String
    let altText: String
    let artKind: StoryArtKind
}

struct StoryChoice: Identifiable, Codable, Hashable {
    let id: String
    let label: String
    let symbol: String
    let isCorrect: Bool
    let accessibilityLabel: String
}

struct StoryQuestion: Identifiable, Codable, Hashable {
    let id: String
    let referencedPageID: String
    let prompt: String
    let choices: [StoryChoice]
    let correctResponse: String
    let correctionResponse: String
}

struct StoryBook: Identifiable, Codable, Hashable {
    let id: String
    let schemaVersion: Int
    let contentVersion: String
    let title: String
    let locale: String
    let coverAsset: String
    let pages: [StoryPage]
    let questions: [StoryQuestion]
}

enum StoryTimePhase: Equatable {
    case cover
    case reading
    case storyComplete
    case reviewIntro
    case reviewQuestion
    case reviewCorrection
    case reviewFeedback
    case reviewComplete
}

struct StorySessionRecord: Codable, Identifiable {
    let id: UUID
    let storyID: String
    let contentVersion: String
    let startedAt: Date
    let endedAt: Date
    let lastPageIndex: Int
    let storyCompleted: Bool
    let narrationReplayCount: Int
    let reviewCompleted: Bool
    let questionsPresented: Int
    let firstTryCorrect: Int
    let correctedAfterHelp: Int
    let durationSeconds: Int
}
