import Foundation

struct SeededRandomGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        state = seed == 0 ? 0x9E3779B97F4A7C15 : seed
    }

    mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var value = state
        value = (value ^ (value >> 30)) &* 0xBF58476D1CE4E5B9
        value = (value ^ (value >> 27)) &* 0x94D049BB133111EB
        return value ^ (value >> 31)
    }
}

enum TargetSelector {
    static func select(from candidates: [HiddenTarget], limit: Int, seed: UInt64, excluding excludedIDs: Set<String> = []) -> [HiddenTarget] {
        let desiredLimit = min(max(limit, 1), 5)
        var preferred = candidates.filter { !excludedIDs.contains($0.id) }
        if preferred.count < desiredLimit { preferred = candidates }

        var generator = SeededRandomGenerator(seed: seed)
        let shuffled = preferred.shuffled(using: &generator)

        // Begin with a mixed difficulty set whenever the scene supports it.
        var selected: [HiddenTarget] = []
        for difficulty in [TargetDifficulty.easy, .medium, .challenging] {
            if let target = shuffled.first(where: { $0.difficulty == difficulty }) {
                selected.append(target)
            }
        }
        for target in shuffled where selected.count < desiredLimit && !selected.contains(target) {
            selected.append(target)
        }
        return Array(selected.prefix(desiredLimit))
    }
}

enum SceneCoordinateTransform {
    static func aspectFitRect(imageSize: CGSize, containerSize: CGSize) -> CGRect {
        guard imageSize.width > 0, imageSize.height > 0, containerSize.width > 0, containerSize.height > 0 else { return .zero }
        let scale = min(containerSize.width / imageSize.width, containerSize.height / imageSize.height)
        let size = CGSize(width: imageSize.width * scale, height: imageSize.height * scale)
        return CGRect(x: (containerSize.width - size.width) / 2, y: (containerSize.height - size.height) / 2, width: size.width, height: size.height)
    }

    static func normalize(_ point: CGPoint, in renderedImageRect: CGRect) -> NormalizedPoint? {
        guard renderedImageRect.contains(point), renderedImageRect.width > 0, renderedImageRect.height > 0 else { return nil }
        return NormalizedPoint(
            x: (point.x - renderedImageRect.minX) / renderedImageRect.width,
            y: (point.y - renderedImageRect.minY) / renderedImageRect.height
        )
    }
}
