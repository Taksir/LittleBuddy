import Foundation

enum AudioRiddleCatalog {
    static let riddles: [AudioRiddle] = [
        // Riddle 1: Clara the Crow & Pitcher
        AudioRiddle(
            id: "crow-pitcher",
            prompt: "Who am I?",
            clueText: "I dropped small pebbles one by one into a tall glass jar so the water level would rise!",
            audioTranscript: "I dropped small pebbles into a tall glass jar so I could get a drink of water. Who am I?",
            options: [
                AudioRiddleOption(id: "crow-1", title: "Clara the Crow", storyID: "crow-and-pitcher", assetVersion: "v1", imageAsset: "page-05", isCorrect: true),
                AudioRiddleOption(id: "hare-1", title: "Hugo the Hare", storyID: "tortoise-and-hare", assetVersion: "v1", imageAsset: "page-06", isCorrect: false),
                AudioRiddleOption(id: "lion-1", title: "Leo the Lion", storyID: "lion-and-mouse", assetVersion: "v1", imageAsset: "page-01", isCorrect: false),
                AudioRiddleOption(id: "cowboy-1", title: "Cole the Cowboy", storyID: "cowboy-who-cried-tiger", assetVersion: "v1", imageAsset: "page-02", isCorrect: false)
            ],
            hintText: "Look for the bird dropping rocks into a tall jar!"
        ),

        // Riddle 2: Hugo the Hare sleeping
        AudioRiddle(
            id: "hare-sleeping",
            prompt: "Who am I?",
            clueText: "I fell fast asleep beneath a big oak tree during a race because I was sure I was fast enough to win!",
            audioTranscript: "I was so fast that I took a cozy nap beneath an oak tree during the race. Who am I?",
            options: [
                AudioRiddleOption(id: "hare-2", title: "Hugo the Hare", storyID: "tortoise-and-hare", assetVersion: "v1", imageAsset: "page-06", isCorrect: true),
                AudioRiddleOption(id: "tortoise-1", title: "Tessa the Tortoise", storyID: "tortoise-and-hare", assetVersion: "v1", imageAsset: "page-09", isCorrect: false),
                AudioRiddleOption(id: "ant-1", title: "Summer Ant", storyID: "ant-and-grasshopper", assetVersion: "v1", imageAsset: "page-01", isCorrect: false),
                AudioRiddleOption(id: "goat-1", title: "Two Goats", storyID: "two-goats", assetVersion: "v1", imageAsset: "page-05", isCorrect: false)
            ],
            hintText: "Look for the sleeping hare under the big green tree!"
        ),

        // Riddle 3: Mina the Mouse & Net
        AudioRiddle(
            id: "mouse-rope-net",
            prompt: "Who am I?",
            clueText: "I used my tiny sharp teeth to chew through heavy rope knots and free a mighty lion!",
            audioTranscript: "Even though I am tiny, I used my teeth to chew the ropes and set my friend free. Who am I?",
            options: [
                AudioRiddleOption(id: "mouse-1", title: "Mina the Mouse", storyID: "lion-and-mouse", assetVersion: "v1", imageAsset: "page-07", isCorrect: true),
                AudioRiddleOption(id: "lion-2", title: "Leo the Lion", storyID: "lion-and-mouse", assetVersion: "v1", imageAsset: "page-01", isCorrect: false),
                AudioRiddleOption(id: "crow-2", title: "Clara the Crow", storyID: "crow-and-pitcher", assetVersion: "v1", imageAsset: "page-01", isCorrect: false),
                AudioRiddleOption(id: "dog-1", title: "Barnaby the Dog", storyID: "dog-and-his-reflection", assetVersion: "v1", imageAsset: "page-01", isCorrect: false)
            ],
            hintText: "Look for the small mouse helping at the rope net!"
        ),

        // Riddle 4: Cole the Cowboy
        AudioRiddle(
            id: "cowboy-tiger-lie",
            prompt: "Who am I?",
            clueText: "I shouted 'Tiger! Tiger!' as a joke when there was no danger, so people stopped believing me!",
            audioTranscript: "I shouted 'Tiger!' just for fun when there was no tiger around. Who am I?",
            options: [
                AudioRiddleOption(id: "cowboy-2", title: "Cole the Cowboy", storyID: "cowboy-who-cried-tiger", assetVersion: "v1", imageAsset: "page-02", isCorrect: true),
                AudioRiddleOption(id: "country-1", title: "Country Mouse", storyID: "town-mouse-and-country-mouse", assetVersion: "v1", imageAsset: "page-01", isCorrect: false),
                AudioRiddleOption(id: "hare-3", title: "Hugo the Hare", storyID: "tortoise-and-hare", assetVersion: "v1", imageAsset: "page-01", isCorrect: false),
                AudioRiddleOption(id: "ant-2", title: "Summer Ant", storyID: "ant-and-grasshopper", assetVersion: "v1", imageAsset: "page-01", isCorrect: false)
            ],
            hintText: "Look for the cowboy calling out near the fence!"
        ),

        // Riddle 5: Tessa the Tortoise
        AudioRiddle(
            id: "tortoise-finish",
            prompt: "Who am I?",
            clueText: "I walked one steady step at a time without stopping, and I crossed the finish line first!",
            audioTranscript: "I kept walking steady and slow, and I crossed the finish line to win the race. Who am I?",
            options: [
                AudioRiddleOption(id: "tortoise-2", title: "Tessa the Tortoise", storyID: "tortoise-and-hare", assetVersion: "v1", imageAsset: "page-09", isCorrect: true),
                AudioRiddleOption(id: "grasshopper-1", title: "Gideon Grasshopper", storyID: "ant-and-grasshopper", assetVersion: "v1", imageAsset: "page-02", isCorrect: false),
                AudioRiddleOption(id: "crow-3", title: "Clara the Crow", storyID: "crow-and-pitcher", assetVersion: "v1", imageAsset: "page-05", isCorrect: false),
                AudioRiddleOption(id: "mouse-2", title: "Mina the Mouse", storyID: "lion-and-mouse", assetVersion: "v1", imageAsset: "page-01", isCorrect: false)
            ],
            hintText: "Look for the tortoise crossing the ribbon at the finish line!"
        ),

        // Riddle 6: Two Goats on Bridge
        AudioRiddle(
            id: "two-goats-bridge",
            prompt: "Who are we?",
            clueText: "We met in the middle of a narrow log bridge over a deep stream and locked horns!",
            audioTranscript: "We met on a very narrow bridge over a river and refused to move out of the way. Who are we?",
            options: [
                AudioRiddleOption(id: "goats-2", title: "The Two Goats", storyID: "two-goats", assetVersion: "v1", imageAsset: "page-05", isCorrect: true),
                AudioRiddleOption(id: "cowboy-3", title: "Cole the Cowboy", storyID: "cowboy-who-cried-tiger", assetVersion: "v1", imageAsset: "page-06", isCorrect: false),
                AudioRiddleOption(id: "town-1", title: "Town Mouse", storyID: "town-mouse-and-country-mouse", assetVersion: "v1", imageAsset: "page-04", isCorrect: false),
                AudioRiddleOption(id: "lion-3", title: "Leo the Lion", storyID: "lion-and-mouse", assetVersion: "v1", imageAsset: "page-07", isCorrect: false)
            ],
            hintText: "Look for the two goats standing face-to-face on the narrow bridge!"
        ),

        // Riddle 7: Barnaby the Dog & Reflection
        AudioRiddle(
            id: "dog-reflection",
            prompt: "Who am I?",
            clueText: "I carried a juicy bone in my mouth across a bridge and tried to snap at my own reflection in the water!",
            audioTranscript: "I looked into the stream, saw another dog with a bone, and opened my mouth to bark! Who am I?",
            options: [
                AudioRiddleOption(id: "dog-2", title: "Barnaby the Dog", storyID: "dog-and-his-reflection", assetVersion: "v1", imageAsset: "page-01", isCorrect: true),
                AudioRiddleOption(id: "hare-4", title: "Hugo the Hare", storyID: "tortoise-and-hare", assetVersion: "v1", imageAsset: "page-06", isCorrect: false),
                AudioRiddleOption(id: "crow-4", title: "Clara the Crow", storyID: "crow-and-pitcher", assetVersion: "v1", imageAsset: "page-05", isCorrect: false),
                AudioRiddleOption(id: "mouse-3", title: "Mina the Mouse", storyID: "lion-and-mouse", assetVersion: "v1", imageAsset: "page-07", isCorrect: false)
            ],
            hintText: "Look for the dog carrying a bone beside the quiet stream!"
        ),

        // Riddle 8: Town Mouse
        AudioRiddle(
            id: "town-mouse-bakery",
            prompt: "Who am I?",
            clueText: "I loved city lights, warm bakeries, and eating soft bread crumbs in a bustling kitchen!",
            audioTranscript: "I invited my country friend to come visit the big city and taste delicious pastries. Who am I?",
            options: [
                AudioRiddleOption(id: "town-2", title: "Town Mouse", storyID: "town-mouse-and-country-mouse", assetVersion: "v1", imageAsset: "page-04", isCorrect: true),
                AudioRiddleOption(id: "country-2", title: "Country Mouse", storyID: "town-mouse-and-country-mouse", assetVersion: "v1", imageAsset: "page-01", isCorrect: false),
                AudioRiddleOption(id: "tortoise-3", title: "Tessa the Tortoise", storyID: "tortoise-and-hare", assetVersion: "v1", imageAsset: "page-09", isCorrect: false),
                AudioRiddleOption(id: "goats-3", title: "The Two Goats", storyID: "two-goats", assetVersion: "v1", imageAsset: "page-05", isCorrect: false)
            ],
            hintText: "Look for the fancy mouse enjoying bakery food in the city!"
        )
    ]

    static var validationIssues: [String] {
        var issues: [String] = []
        var seenRiddleIDs = Set<String>()
        let validStoryIDs = Set(StoryCatalog.allBooks.map(\.id))

        for riddle in riddles {
            if riddle.id.isEmpty {
                issues.append("Riddle has empty ID")
            }
            if seenRiddleIDs.contains(riddle.id) {
                issues.append("Duplicate riddle ID: \(riddle.id)")
            }
            seenRiddleIDs.insert(riddle.id)

            if riddle.prompt.isEmpty {
                issues.append("Riddle \(riddle.id) has empty prompt")
            }
            if riddle.clueText.isEmpty {
                issues.append("Riddle \(riddle.id) has empty clueText")
            }
            if riddle.audioTranscript.isEmpty {
                issues.append("Riddle \(riddle.id) has empty audioTranscript")
            }
            if riddle.hintText.isEmpty {
                issues.append("Riddle \(riddle.id) has empty hintText")
            }

            if riddle.options.count != 4 {
                issues.append("Riddle \(riddle.id) must have exactly 4 options, found \(riddle.options.count)")
            }

            let correctCount = riddle.options.filter(\.isCorrect).count
            if correctCount != 1 {
                issues.append("Riddle \(riddle.id) must have exactly 1 correct option, found \(correctCount)")
            }

            var seenOptionIDs = Set<String>()
            for option in riddle.options {
                if option.id.isEmpty {
                    issues.append("Riddle \(riddle.id) has option with empty ID")
                }
                if seenOptionIDs.contains(option.id) {
                    issues.append("Riddle \(riddle.id) has duplicate option ID: \(option.id)")
                }
                seenOptionIDs.insert(option.id)

                if option.title.isEmpty {
                    issues.append("Option \(option.id) in \(riddle.id) has empty title")
                }
                if let referencedBook = StoryCatalog.allBooks.first(where: { $0.id == option.storyID }) {
                    if option.assetVersion != referencedBook.assetVersion {
                        issues.append("Option \(option.id) in \(riddle.id) has mismatched assetVersion. Expected: \(referencedBook.assetVersion)")
                    }
                    let isValidImage = referencedBook.pages.contains(where: { $0.imageAsset == option.imageAsset }) || referencedBook.coverAsset == option.imageAsset
                    if !isValidImage {
                        issues.append("Option \(option.id) in \(riddle.id) references invalid imageAsset for story: \(option.imageAsset)")
                    }

                    // Verify the file actually exists in the bundle
                    let hasAsset = ["png", "jpg", "jpeg"].contains { ext in
                        Bundle.module.url(forResource: option.imageAsset, withExtension: ext, subdirectory: "Stories/\(referencedBook.id)/\(referencedBook.assetVersion)") != nil
                    }
                    if !hasAsset {
                        issues.append("Option \(option.id) in \(riddle.id) missing image asset file: \(option.imageAsset) in Stories/\(referencedBook.id)/\(referencedBook.assetVersion)")
                    }
                } else {
                    issues.append("Option \(option.id) in \(riddle.id) references invalid storyID: \(option.storyID)")
                }
                if option.imageAsset.isEmpty {
                    issues.append("Option \(option.id) in \(riddle.id) has empty imageAsset")
                }
            }
        }

        return issues
    }
}
