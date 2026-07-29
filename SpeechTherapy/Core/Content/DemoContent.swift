import Foundation

enum DemoContent {
    static let pack: ContentPack = {
        let locations: [(Double, Double)] = [
            (0.12, 0.20), (0.31, 0.17), (0.54, 0.21), (0.76, 0.18), (0.19, 0.48),
            (0.42, 0.45), (0.65, 0.49), (0.84, 0.45), (0.28, 0.73), (0.58, 0.72)
        ]
        let scenes: [(String, String, SceneTheme, [(String, String)])] = [
            ("garden-picnic", "Garden Picnic", .garden, [("bunny", "bunny"), ("hat", "hat"), ("yellow bird", "bird"), ("apple", "apple"), ("flower", "flower"), ("butterfly", "butterfly"), ("blue ball", "ball"), ("spoon", "spoon"), ("toy boat", "boat"), ("star", "star")]),
            ("cozy-playroom", "Cozy Playroom", .playroom, [("teddy", "teddy"), ("block", "block"), ("red car", "car"), ("book", "book"), ("drum", "drum"), ("kite", "kite"), ("puzzle", "puzzle"), ("crayon", "crayon"), ("robot", "robot"), ("balloon", "balloon")]),
            ("friendly-farm", "Friendly Farm", .farm, [("cow", "cow"), ("tractor", "tractor"), ("egg", "egg"), ("carrot", "carrot"), ("chicken", "chicken"), ("boot", "boot"), ("bucket", "bucket"), ("sunflower", "sunflower"), ("duck", "duck"), ("barn", "barn")]),
            ("sunny-beach", "Sunny Beach", .beach, [("seashell", "shell"), ("sandcastle", "sandcastle"), ("crab", "crab"), ("bucket", "bucket"), ("blue fish", "fish"), ("sunglasses", "sunglasses"), ("umbrella", "umbrella"), ("boat", "boat"), ("starfish", "starfish"), ("ball", "ball")]),
            ("woodland-camp", "Woodland Camp", .campsite, [("tent", "tent"), ("lantern", "lantern"), ("backpack", "backpack"), ("acorn", "acorn"), ("owl", "owl"), ("mug", "mug"), ("map", "map"), ("boot", "boot"), ("marshmallow", "marshmallow"), ("flag", "flag")]),
            ("baking-kitchen", "Baking Kitchen", .kitchen, [("cookie", "cookie"), ("cupcake", "cupcake"), ("spoon", "spoon"), ("apple", "apple"), ("teapot", "teapot"), ("bread", "bread"), ("carrot", "carrot"), ("pan", "pan"), ("banana", "banana"), ("plate", "plate")]),
            ("dinosaur-museum", "Dinosaur Museum", .museum, [("dinosaur", "dinosaur"), ("fossil", "fossil"), ("rocket", "rocket"), ("globe", "globe"), ("paintbrush", "paintbrush"), ("crown", "crown"), ("robot", "robot"), ("key", "key"), ("star", "star"), ("feather", "feather")]),
            ("snowy-park", "Snowy Park", .snowyPark, [("snowman", "snowman"), ("scarf", "scarf"), ("sled", "sled"), ("mitten", "mitten"), ("penguin", "penguin"), ("snowflake", "snowflake"), ("boot", "boot"), ("cocoa", "cocoa"), ("lantern", "lantern"), ("igloo", "igloo")]),
            ("coral-reef", "Coral Reef", .reef, [("fish", "fish"), ("turtle", "turtle"), ("seahorse", "seahorse"), ("shell", "shell"), ("starfish", "starfish"), ("anchor", "anchor"), ("coral", "coral"), ("pearl", "pearl"), ("crab", "crab"), ("submarine", "submarine")]),
            ("neighborhood-market", "Neighborhood Market", .market, [("apple", "apple"), ("bread", "bread"), ("flower", "flower"), ("basket", "basket"), ("cheese", "cheese"), ("banana", "banana"), ("carrot", "carrot"), ("hat", "hat"), ("toy bus", "bus"), ("balloon", "balloon")])
        ]

        return ContentPack(
            schemaVersion: 1,
            contentVersion: "0.1.0-demo",
            locale: "en-US",
            activity: "hidden-objects",
            defaults: ContentDefaults(targetsPerSession: 5, visualHintAfterMisses: 3, demonstrateAfterMisses: 5),
            scenes: scenes.map { id, title, theme, objects in
                StoryScene(
                    id: id,
                    title: title,
                    theme: theme,
                    targets: objects.enumerated().map { index, object in
                        let point = locations[index]
                        return HiddenTarget(
                            id: object.1,
                            label: object.0,
                            kind: object.1,
                            difficulty: index < 3 ? .easy : (index < 7 ? .medium : .challenging),
                            geometry: HitGeometry(
                                bbox: NormalizedRect(x: point.0 - 0.055, y: point.1 - 0.065, width: 0.11, height: 0.13),
                                touchExpansion: 0.018
                            )
                        )
                    }
                )
            }
        )
    }()
}
