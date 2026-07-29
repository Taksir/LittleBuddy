import Foundation

enum BundledSceneCatalog {
    static func load() throws -> ContentPack {
        let pack = DemoContent.pack
        try ContentValidator.validate(pack)
        return pack
    }
}
