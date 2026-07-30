import Foundation

struct StoryPage: Identifiable, Codable, Hashable {
    let id: String
    let order: Int
    let title: String
    let imageAsset: String
    let displayedText: String
    let narrationTranscript: String
    let altText: String
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
    let assetVersion: String
    let coverAsset: String
    let pages: [StoryPage]
    let questions: [StoryQuestion]

    var isValid: Bool {
        guard !id.isEmpty,
              !title.isEmpty,
              !locale.isEmpty,
              !assetVersion.isEmpty,
              !coverAsset.isEmpty,
              pages.count == 10,
              questions.count == 4 else {
            return false
        }

        let pageIDs = Set(pages.map(\.id))
        let questionIDs = Set(questions.map(\.id))
        guard pageIDs.count == pages.count,
              questionIDs.count == questions.count,
              pages.allSatisfy({ !$0.title.isEmpty && !$0.imageAsset.isEmpty && !$0.narrationTranscript.isEmpty }),
              questions.allSatisfy({
                  $0.choices.count == 2 &&
                  $0.choices.filter(\.isCorrect).count == 1 &&
                  pageIDs.contains($0.referencedPageID)
              }) else {
            return false
        }

        return true
    }
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
