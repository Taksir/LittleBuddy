import Foundation
import CoreGraphics

struct ContentPack: Codable, Sendable {
    let schemaVersion: Int
    let contentVersion: String
    let locale: String
    let activity: String
    let defaults: ContentDefaults
    let scenes: [StoryScene]
}

struct ContentDefaults: Codable, Sendable {
    let targetsPerSession: Int
    let visualHintAfterMisses: Int
    let demonstrateAfterMisses: Int
}

struct StoryScene: Codable, Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let theme: SceneTheme
    let targets: [HiddenTarget]
}

enum SceneTheme: String, Codable, CaseIterable, Sendable {
    case garden, playroom, farm, beach, campsite, kitchen, museum, snowyPark, reef, market
}

enum TargetDifficulty: String, Codable, Sendable {
    case easy, medium, challenging
}

struct HiddenTarget: Codable, Identifiable, Hashable, Sendable {
    let id: String
    let label: String
    let kind: String
    let difficulty: TargetDifficulty
    let geometry: HitGeometry

    var question: String { "Can you find the \(label)?" }
    var successLine: String { "You found the \(label)!" }
    var hintLine: String { "The \(label) is right here." }
}

struct HitGeometry: Codable, Hashable, Sendable {
    let bbox: NormalizedRect
    let touchExpansion: Double

    func contains(_ point: NormalizedPoint) -> Bool {
        bbox.expanded(by: touchExpansion).contains(point)
    }
}

struct NormalizedPoint: Codable, Hashable, Sendable {
    let x: Double
    let y: Double
}

struct NormalizedRect: Codable, Hashable, Sendable {
    let x: Double
    let y: Double
    let width: Double
    let height: Double

    func contains(_ point: NormalizedPoint) -> Bool {
        point.x >= x && point.x <= x + width && point.y >= y && point.y <= y + height
    }

    func expanded(by amount: Double) -> NormalizedRect {
        let minimumX = max(0, x - amount)
        let minimumY = max(0, y - amount)
        let maximumX = min(1, x + width + amount)
        let maximumY = min(1, y + height + amount)
        return NormalizedRect(x: minimumX, y: minimumY, width: maximumX - minimumX, height: maximumY - minimumY)
    }

    var cgRect: CGRect {
        CGRect(x: x, y: y, width: width, height: height)
    }
}

enum ContentValidationError: LocalizedError, Equatable {
    case unsupportedSchema(Int)
    case wrongSceneCount(Int)
    case wrongTargetCount(sceneID: String, count: Int)
    case duplicateID(String)
    case invalidGeometry(targetID: String)

    var errorDescription: String? {
        switch self {
        case .unsupportedSchema(let version): "Unsupported content schema \(version)."
        case .wrongSceneCount(let count): "Expected 10 scenes, found \(count)."
        case .wrongTargetCount(let sceneID, let count): "Scene \(sceneID) must contain 10 targets, found \(count)."
        case .duplicateID(let id): "Duplicate content id: \(id)."
        case .invalidGeometry(let targetID): "Invalid hit geometry for \(targetID)."
        }
    }
}

enum ContentValidator {
    static func validate(_ pack: ContentPack) throws {
        guard pack.schemaVersion == 1 else { throw ContentValidationError.unsupportedSchema(pack.schemaVersion) }
        guard pack.scenes.count == 10 else { throw ContentValidationError.wrongSceneCount(pack.scenes.count) }

        var ids = Set<String>()
        for scene in pack.scenes {
            guard scene.targets.count == 10 else {
                throw ContentValidationError.wrongTargetCount(sceneID: scene.id, count: scene.targets.count)
            }
            guard ids.insert(scene.id).inserted else { throw ContentValidationError.duplicateID(scene.id) }
            for target in scene.targets {
                let id = "\(scene.id).\(target.id)"
                guard ids.insert(id).inserted else { throw ContentValidationError.duplicateID(id) }
                let box = target.geometry.bbox
                guard box.x >= 0, box.y >= 0, box.width > 0, box.height > 0,
                      box.x + box.width <= 1, box.y + box.height <= 1,
                      target.geometry.touchExpansion >= 0 else {
                    throw ContentValidationError.invalidGeometry(targetID: id)
                }
            }
        }
    }
}
