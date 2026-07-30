import Foundation

struct NormalizedPoint: Hashable {
    let x: Double
    let y: Double
}

struct NormalizedBox: Hashable {
    let x: Double
    let y: Double
    let width: Double
    let height: Double
    let touchExpansion: Double

    var center: NormalizedPoint {
        NormalizedPoint(x: x + width / 2, y: y + height / 2)
    }

    func contains(_ point: NormalizedPoint) -> Bool {
        let left = max(0, x - touchExpansion)
        let top = max(0, y - touchExpansion)
        let right = min(1, x + width + touchExpansion)
        let bottom = min(1, y + height + touchExpansion)
        return point.x >= left && point.x <= right && point.y >= top && point.y <= bottom
    }

    func expandedForPreview() -> NormalizedBox {
        let horizontalPadding = max(0.025, width * 0.35)
        let verticalPadding = max(0.025, height * 0.35)
        let left = max(0, x - horizontalPadding)
        let top = max(0, y - verticalPadding)
        let right = min(1, x + width + horizontalPadding)
        let bottom = min(1, y + height + verticalPadding)
        return NormalizedBox(
            x: left,
            y: top,
            width: right - left,
            height: bottom - top,
            touchExpansion: 0
        )
    }
}

enum TargetDifficulty: String, Hashable {
    case easy
    case medium
    case challenging
}

struct HiddenTarget: Identifiable, Hashable {
    let id: String
    let label: String
    let difficulty: TargetDifficulty
    let box: NormalizedBox

    var question: String { "Can you find the \(label)?" }
    var successLine: String { "You found the \(label)!" }
}

enum SceneTheme: String, CaseIterable {
    case garden
    case playroom
    case farm
    case beach
    case campsite
    case kitchen
    case museum
    case snowyPark
    case reef
    case market
}

struct StoryScene: Identifiable {
    let id: String
    let title: String
    let imageName: String
    let theme: SceneTheme
    let targets: [HiddenTarget]
}

enum GameplayPhase: Equatable {
    case ready
    case asking
    case awaitingTap
    case respondingToMiss
    case showingHint
    case celebrating
    case demonstrating
    case completed
}

enum AppRoute: Equatable {
    case home
    case play(UUID)
    case storyLibrary
    case story(storyID: String, sessionToken: UUID)
    case parentGate(ParentDestination)
    case dashboard
    case settings
}

enum ParentDestination: Equatable {
    case dashboard
    case settings
}
