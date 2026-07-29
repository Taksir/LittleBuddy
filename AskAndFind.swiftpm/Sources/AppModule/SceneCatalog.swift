import Foundation

enum SceneCatalog {
    static let scenes: [StoryScene] = {
        let positions: [(Double, Double)] = [
            (0.12, 0.20), (0.31, 0.17), (0.54, 0.21), (0.76, 0.18), (0.19, 0.48),
            (0.42, 0.45), (0.65, 0.49), (0.84, 0.45), (0.28, 0.73), (0.58, 0.72)
        ]

        let definitions: [(String, String, SceneTheme, [(String, String, String)])] = [
            ("garden-picnic", "Garden Picnic", .garden, [("bunny", "bunny", "🐰"), ("hat", "hat", "👒"), ("yellow-bird", "yellow bird", "🐤"), ("apple", "apple", "🍎"), ("flower", "flower", "🌸"), ("butterfly", "butterfly", "🦋"), ("blue-ball", "blue ball", "🔵"), ("spoon", "spoon", "🥄"), ("toy-boat", "toy boat", "⛵"), ("star", "star", "⭐️")]),
            ("cozy-playroom", "Cozy Playroom", .playroom, [("teddy", "teddy", "🧸"), ("block", "block", "🧱"), ("red-car", "red car", "🚗"), ("book", "book", "📘"), ("drum", "drum", "🥁"), ("kite", "kite", "🪁"), ("puzzle", "puzzle", "🧩"), ("crayon", "crayon", "🖍️"), ("robot", "robot", "🤖"), ("balloon", "balloon", "🎈")]),
            ("friendly-farm", "Friendly Farm", .farm, [("cow", "cow", "🐮"), ("tractor", "tractor", "🚜"), ("egg", "egg", "🥚"), ("carrot", "carrot", "🥕"), ("chicken", "chicken", "🐔"), ("boot", "boot", "🥾"), ("bucket", "bucket", "🪣"), ("sunflower", "sunflower", "🌻"), ("duck", "duck", "🦆"), ("barn", "barn", "🏠")]),
            ("sunny-beach", "Sunny Beach", .beach, [("seashell", "seashell", "🐚"), ("sandcastle", "sandcastle", "🏰"), ("crab", "crab", "🦀"), ("bucket", "bucket", "🪣"), ("blue-fish", "blue fish", "🐟"), ("sunglasses", "sunglasses", "🕶️"), ("umbrella", "umbrella", "⛱️"), ("boat", "boat", "⛵"), ("starfish", "starfish", "🌟"), ("ball", "ball", "🔵")]),
            ("woodland-camp", "Woodland Camp", .campsite, [("tent", "tent", "⛺"), ("lantern", "lantern", "🏮"), ("backpack", "backpack", "🎒"), ("acorn", "acorn", "🌰"), ("owl", "owl", "🦉"), ("mug", "mug", "☕️"), ("map", "map", "🗺️"), ("boot", "boot", "🥾"), ("marshmallow", "marshmallow", "🍡"), ("flag", "flag", "🚩")]),
            ("baking-kitchen", "Baking Kitchen", .kitchen, [("cookie", "cookie", "🍪"), ("cupcake", "cupcake", "🧁"), ("spoon", "spoon", "🥄"), ("apple", "apple", "🍎"), ("teapot", "teapot", "🫖"), ("bread", "bread", "🍞"), ("carrot", "carrot", "🥕"), ("pan", "pan", "🍳"), ("banana", "banana", "🍌"), ("plate", "plate", "🍽️")]),
            ("dinosaur-museum", "Dinosaur Museum", .museum, [("dinosaur", "dinosaur", "🦕"), ("fossil", "fossil", "🦴"), ("rocket", "rocket", "🚀"), ("globe", "globe", "🌎"), ("paintbrush", "paintbrush", "🖌️"), ("crown", "crown", "👑"), ("robot", "robot", "🤖"), ("key", "key", "🔑"), ("star", "star", "⭐️"), ("feather", "feather", "🪶")]),
            ("snowy-park", "Snowy Park", .snowyPark, [("snowman", "snowman", "☃️"), ("scarf", "scarf", "🧣"), ("sled", "sled", "🛷"), ("mitten", "mitten", "🧤"), ("penguin", "penguin", "🐧"), ("snowflake", "snowflake", "❄️"), ("boot", "boot", "🥾"), ("cocoa", "cocoa", "☕️"), ("lantern", "lantern", "🏮"), ("igloo", "igloo", "🧊")]),
            ("coral-reef", "Coral Reef", .reef, [("fish", "fish", "🐟"), ("turtle", "turtle", "🐢"), ("seahorse", "seahorse", "🐴"), ("shell", "shell", "🐚"), ("starfish", "starfish", "🌟"), ("anchor", "anchor", "⚓️"), ("coral", "coral", "🪸"), ("pearl", "pearl", "⚪️"), ("crab", "crab", "🦀"), ("submarine", "submarine", "🚤")]),
            ("neighborhood-market", "Neighborhood Market", .market, [("apple", "apple", "🍎"), ("bread", "bread", "🍞"), ("flower", "flower", "🌸"), ("basket", "basket", "🧺"), ("cheese", "cheese", "🧀"), ("banana", "banana", "🍌"), ("carrot", "carrot", "🥕"), ("hat", "hat", "👒"), ("toy-bus", "toy bus", "🚌"), ("balloon", "balloon", "🎈")])
        ]

        return definitions.map { sceneID, title, theme, objects in
            StoryScene(
                id: sceneID,
                title: title,
                theme: theme,
                targets: objects.enumerated().map { index, object in
                    let position = positions[index]
                    return HiddenTarget(
                        id: object.0,
                        label: object.1,
                        symbol: object.2,
                        difficulty: index < 3 ? .easy : (index < 7 ? .medium : .challenging),
                        box: NormalizedBox(
                            x: position.0 - 0.055,
                            y: position.1 - 0.065,
                            width: 0.11,
                            height: 0.13,
                            touchExpansion: 0.018
                        )
                    )
                }
            )
        }
    }()

    static func selectTargets(from scene: StoryScene, limit: Int) -> [HiddenTarget] {
        let count = min(max(limit, 3), 5)
        let shuffled = scene.targets.shuffled()
        var result: [HiddenTarget] = []
        for difficulty in [TargetDifficulty.easy, .medium, .challenging] {
            if let target = shuffled.first(where: { $0.difficulty == difficulty }) {
                result.append(target)
            }
        }
        for target in shuffled where result.count < count && !result.contains(target) {
            result.append(target)
        }
        return Array(result.prefix(count))
    }
}
