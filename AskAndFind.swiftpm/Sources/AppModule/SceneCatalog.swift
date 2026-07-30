import Foundation

enum SceneCatalog {
    static let scenes: [StoryScene] = [
        StoryScene(
            id: "garden-picnic",
            title: "Garden Picnic",
            imageName: "garden-picnic",
            theme: .garden,
            targets: [
                t("bunny", "bunny", .easy, 0.44, 0.37, 0.11, 0.20),
                t("hat", "hat", .easy, 0.61, 0.63, 0.21, 0.18),
                t("yellow-bird", "yellow bird", .easy, 0.80, 0.02, 0.14, 0.16),
                t("apple", "apple", .medium, 0.11, 0.72, 0.11, 0.17),
                t("pink-flower", "pink flower", .medium, 0.29, 0.74, 0.11, 0.17),
                t("butterfly", "butterfly", .medium, 0.09, 0.03, 0.11, 0.15),
                t("blue-ball", "blue ball", .medium, 0.78, 0.74, 0.14, 0.20),
                t("spoon", "spoon", .challenging, 0.42, 0.67, 0.17, 0.09, 0.025),
                t("toy-boat", "toy boat", .challenging, 0.05, 0.43, 0.12, 0.21),
                t("star-patch", "star patch", .challenging, 0.84, 0.52, 0.09, 0.13, 0.025)
            ]
        ),
        StoryScene(
            id: "cozy-playroom",
            title: "Cozy Playroom",
            imageName: "cozy-playroom",
            theme: .playroom,
            targets: [
                t("teddy", "teddy bear", .easy, 0.02, 0.43, 0.17, 0.31),
                t("red-car", "red car", .easy, 0.40, 0.73, 0.17, 0.21),
                t("drum", "drum", .easy, 0.80, 0.60, 0.19, 0.30),
                t("red-balloon", "red balloon", .medium, 0.01, 0.01, 0.14, 0.28),
                t("kite", "kite", .medium, 0.43, 0.02, 0.16, 0.30),
                t("robot", "robot", .medium, 0.67, 0.04, 0.11, 0.25),
                t("blue-book", "blue book", .medium, 0.19, 0.68, 0.19, 0.20),
                t("puzzle-piece", "puzzle piece", .challenging, 0.06, 0.81, 0.15, 0.16),
                t("purple-crayon", "purple crayon", .challenging, 0.32, 0.88, 0.14, 0.10, 0.025),
                t("yellow-block", "yellow block", .challenging, 0.71, 0.83, 0.11, 0.16)
            ]
        ),
        StoryScene(
            id: "friendly-farm",
            title: "Friendly Farm",
            imageName: "friendly-farm",
            theme: .farm,
            targets: [
                t("cow", "cow", .easy, 0.02, 0.29, 0.31, 0.39),
                t("barn", "barn", .easy, 0.71, 0.02, 0.28, 0.43),
                t("yellow-duck", "yellow duck", .easy, 0.03, 0.65, 0.16, 0.28),
                t("tractor", "tractor", .medium, 0.39, 0.15, 0.17, 0.18),
                t("chicken", "chicken", .medium, 0.78, 0.37, 0.13, 0.21),
                t("carrot", "carrot", .medium, 0.51, 0.67, 0.16, 0.11),
                t("blue-bucket", "blue bucket", .medium, 0.78, 0.70, 0.14, 0.23),
                t("sunflower", "sunflower", .challenging, 0.04, 0.02, 0.14, 0.29),
                t("egg", "egg", .challenging, 0.28, 0.66, 0.08, 0.11, 0.025),
                t("green-boot", "green boot", .challenging, 0.55, 0.74, 0.14, 0.23)
            ]
        ),
        StoryScene(
            id: "sunny-beach",
            title: "Sunny Beach",
            imageName: "sunny-beach",
            theme: .beach,
            targets: [
                t("sandcastle", "sandcastle", .easy, 0.31, 0.43, 0.20, 0.29),
                t("yellow-bucket", "yellow bucket", .easy, 0.77, 0.52, 0.14, 0.22),
                t("beach-ball", "beach ball", .easy, 0.73, 0.72, 0.19, 0.25),
                t("umbrella", "beach umbrella", .medium, 0.00, 0.00, 0.36, 0.35),
                t("pink-shell", "pink seashell", .medium, 0.09, 0.57, 0.10, 0.15),
                t("red-crab", "red crab", .medium, 0.45, 0.64, 0.12, 0.15),
                t("orange-starfish", "orange starfish", .medium, 0.37, 0.78, 0.14, 0.17),
                t("sailboat", "sailboat", .challenging, 0.64, 0.07, 0.08, 0.14, 0.025),
                t("blue-fish", "blue fish", .challenging, 0.80, 0.37, 0.09, 0.13, 0.025),
                t("green-sunglasses", "green sunglasses", .challenging, 0.11, 0.73, 0.22, 0.18)
            ]
        ),
        StoryScene(
            id: "woodland-camp",
            title: "Woodland Camp",
            imageName: "woodland-camp",
            theme: .campsite,
            targets: [
                t("tent", "tent", .easy, 0.74, 0.13, 0.25, 0.38),
                t("lantern", "lantern", .easy, 0.03, 0.41, 0.15, 0.34),
                t("blue-backpack", "blue backpack", .easy, 0.20, 0.48, 0.16, 0.28),
                t("owl", "owl", .medium, 0.13, 0.05, 0.11, 0.23),
                t("map", "map", .medium, 0.38, 0.61, 0.16, 0.13),
                t("red-mug", "red mug", .medium, 0.84, 0.64, 0.12, 0.15),
                t("green-boot", "green boot", .medium, 0.35, 0.73, 0.16, 0.23),
                t("red-flag", "red flag", .challenging, 0.51, 0.18, 0.08, 0.17, 0.025),
                t("acorn", "acorn", .challenging, 0.15, 0.80, 0.10, 0.11, 0.025),
                t("marshmallow", "marshmallow", .challenging, 0.62, 0.79, 0.13, 0.14, 0.025)
            ]
        ),
        StoryScene(
            id: "baking-kitchen",
            title: "Baking Kitchen",
            imageName: "baking-kitchen",
            theme: .kitchen,
            targets: [
                t("red-apple", "red apple", .easy, 0.04, 0.65, 0.14, 0.18),
                t("pink-cupcake", "pink cupcake", .easy, 0.28, 0.70, 0.11, 0.18),
                t("yellow-banana", "yellow banana", .easy, 0.43, 0.80, 0.16, 0.16),
                t("blue-teapot", "blue teapot", .medium, 0.16, 0.02, 0.14, 0.16),
                t("bread", "bread", .medium, 0.54, 0.33, 0.12, 0.11),
                t("black-pan", "black pan", .medium, 0.84, 0.04, 0.12, 0.26),
                t("white-plate", "white plate", .medium, 0.62, 0.78, 0.19, 0.17),
                t("cookie", "cookie", .challenging, 0.13, 0.79, 0.12, 0.14),
                t("spoon", "spoon", .challenging, 0.35, 0.77, 0.12, 0.15, 0.025),
                t("carrot", "carrot", .challenging, 0.75, 0.75, 0.24, 0.19)
            ]
        ),
        StoryScene(
            id: "dinosaur-museum",
            title: "Dinosaur Museum",
            imageName: "dinosaur-museum",
            theme: .museum,
            targets: [
                t("dinosaur", "dinosaur skeleton", .easy, 0.00, 0.10, 0.40, 0.54),
                t("globe", "globe", .easy, 0.38, 0.01, 0.13, 0.24),
                t("crown", "crown", .easy, 0.80, 0.04, 0.15, 0.25),
                t("rocket", "red rocket", .medium, 0.10, 0.02, 0.19, 0.19),
                t("fossil", "spiral fossil", .medium, 0.21, 0.61, 0.16, 0.25),
                t("robot", "silver robot", .medium, 0.59, 0.61, 0.11, 0.28),
                t("yellow-star", "yellow star", .medium, 0.49, 0.78, 0.13, 0.18),
                t("gold-key", "gold key", .challenging, 0.08, 0.77, 0.16, 0.17),
                t("paintbrush", "paintbrush", .challenging, 0.34, 0.77, 0.17, 0.16),
                t("blue-feather", "blue feather", .challenging, 0.72, 0.78, 0.23, 0.17)
            ]
        ),
        StoryScene(
            id: "snowy-park",
            title: "Snowy Park",
            imageName: "snowy-park",
            theme: .snowyPark,
            targets: [
                t("snowman", "snowman", .easy, 0.02, 0.28, 0.17, 0.38),
                t("red-sled", "red sled", .easy, 0.38, 0.43, 0.24, 0.20),
                t("penguin", "penguin", .easy, 0.79, 0.27, 0.12, 0.23),
                t("snowflake", "snowflake", .medium, 0.04, 0.00, 0.15, 0.26),
                t("striped-scarf", "striped scarf", .medium, 0.24, 0.65, 0.23, 0.23),
                t("lantern", "lantern", .medium, 0.82, 0.50, 0.13, 0.28),
                t("cocoa", "mug of cocoa", .medium, 0.73, 0.75, 0.17, 0.24),
                t("igloo", "igloo", .challenging, 0.34, 0.13, 0.15, 0.22),
                t("blue-mitten", "blue mitten", .challenging, 0.06, 0.72, 0.17, 0.19),
                t("green-boot", "green boot", .challenging, 0.45, 0.71, 0.16, 0.23)
            ]
        ),
        StoryScene(
            id: "coral-reef",
            title: "Coral Reef",
            imageName: "coral-reef",
            theme: .reef,
            targets: [
                t("turtle", "sea turtle", .easy, 0.41, 0.04, 0.20, 0.21),
                t("anchor", "anchor", .easy, 0.81, 0.36, 0.15, 0.33),
                t("red-crab", "red crab", .easy, 0.70, 0.71, 0.19, 0.24),
                t("submarine", "yellow submarine", .medium, 0.06, 0.05, 0.15, 0.17),
                t("blue-fish", "blue fish", .medium, 0.04, 0.47, 0.17, 0.18),
                t("pink-shell", "pink shell", .medium, 0.32, 0.54, 0.12, 0.18),
                t("orange-starfish", "orange starfish", .medium, 0.45, 0.76, 0.18, 0.21),
                t("seahorse", "seahorse", .challenging, 0.83, 0.06, 0.09, 0.25),
                t("red-coral", "red coral", .challenging, 0.47, 0.47, 0.17, 0.33),
                t("pearl", "pearl", .challenging, 0.08, 0.69, 0.20, 0.24)
            ]
        ),
        StoryScene(
            id: "neighborhood-market",
            title: "Neighborhood Market",
            imageName: "neighborhood-market",
            theme: .market,
            targets: [
                t("red-apple", "red apple", .easy, 0.16, 0.54, 0.13, 0.19),
                t("bread", "loaf of bread", .easy, 0.28, 0.75, 0.22, 0.21),
                t("basket", "basket", .easy, 0.68, 0.47, 0.22, 0.35),
                t("red-balloon", "red balloon", .medium, 0.02, 0.00, 0.14, 0.27),
                t("straw-hat", "straw hat", .medium, 0.49, 0.01, 0.13, 0.27),
                t("yellow-bus", "yellow toy bus", .medium, 0.80, 0.02, 0.15, 0.17),
                t("pink-flower", "pink flower", .medium, 0.48, 0.57, 0.13, 0.26),
                t("cheese", "cheese", .challenging, 0.04, 0.74, 0.16, 0.23),
                t("banana", "banana", .challenging, 0.48, 0.80, 0.20, 0.17),
                t("carrot", "carrot", .challenging, 0.67, 0.79, 0.24, 0.18)
            ]
        )
    ]

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

    private static func t(
        _ id: String,
        _ label: String,
        _ difficulty: TargetDifficulty,
        _ x: Double,
        _ y: Double,
        _ width: Double,
        _ height: Double,
        _ touchExpansion: Double = 0.018
    ) -> HiddenTarget {
        HiddenTarget(
            id: id,
            label: label,
            difficulty: difficulty,
            box: NormalizedBox(
                x: x,
                y: y,
                width: width,
                height: height,
                touchExpansion: touchExpansion
            )
        )
    }
}
