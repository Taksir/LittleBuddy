import Foundation

enum StoryCatalog {
    static let cowboyWhoCriedTiger = StoryBook(
        id: "cowboy-who-cried-tiger",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Cowboy Who Cried Tiger",
        locale: "en-US",
        coverAsset: "cover",
        pages: [
            page(
                1,
                "The Ranch",
                "Cole was a cowboy. Each day, he watched the calves near the tall grass while the other ranchers worked nearby.",
                "Wide ranch view with Cole on a fence, calves in the middle, and two ranchers repairing a gate.",
                .ranch
            ),
            page(
                2,
                "The First Lie",
                "One quiet afternoon, Cole felt bored. He shouted, \"Tiger! Tiger! Please help!\" But there was no tiger.",
                "Cole calls toward empty tall grass while the ranch and calves remain safe behind him.",
                .emptyGrass
            ),
            page(
                3,
                "The Joke",
                "Mara and Ben hurried to Cole. Cole laughed. \"I fooled you!\" The ranchers felt worried, not amused.",
                "Two ranchers arrive with calm concern while Cole laughs beside the fence.",
                .ranchers
            ),
            page(
                4,
                "The Second Lie",
                "The next day, Cole called \"Tiger!\" again. Again, the ranchers ran to help. Again, there was no tiger.",
                "Cole calls near a water trough as the ranchers approach and the grass stays empty.",
                .warning
            ),
            page(
                5,
                "The Warning",
                "\"Only call when danger is real,\" Mara said. \"If you keep lying, we may not believe you.\"",
                "Mara speaks gently at Cole's eye level while Ben listens nearby.",
                .ranchers
            ),
            page(
                6,
                "A Real Tiger",
                "Soon, the tall grass rustled. A real tiger crept toward Cole. This time, he was telling the truth.",
                "Cole sees a tiger emerging from distant grass, with plenty of safe space between them.",
                .tiger
            ),
            page(
                7,
                "No One Comes",
                "\"Tiger! Please help!\" Cole cried. The ranchers heard him, but they thought it was another trick.",
                "Cole calls from a far hill while the ranchers pause by the barn, unsure whether to believe him.",
                .distantCall
            ),
            page(
                8,
                "The Consequence",
                "No one came in time. The tiger caught Cole and gobbled him up.",
                "An empty sunset field with Cole's hat, bent grass, and tiger tracks. No attack, injury, or remains.",
                .quietField
            ),
            page(
                9,
                "The Ranchers Understand",
                "Later, Mara and Ben found Cole's hat and the tiger tracks. They were sad that they had not known his warning was true.",
                "Mara holds Cole's hat while Ben studies the tracks in soft evening light.",
                .tracks
            ),
            page(
                10,
                "The Lesson",
                "Telling the truth helps people trust us. If you are ever in danger, keep calling for a trusted grown-up.",
                "A comforting ranch sunrise with calves, a secure fence, and Cole's hat hanging by the barn.",
                .sunrise
            )
        ],
        questions: [
            StoryQuestion(
                id: "q1-first-call",
                referencedPageID: "page-02",
                prompt: "Was there really a tiger the first time Cole called for help?",
                choices: [
                    choice("no-tiger", "No tiger", "leaf.fill", true, "No tiger"),
                    choice("real-tiger", "A real tiger", "pawprint.fill", false, "A real tiger")
                ],
                correctResponse: "That's right. The grass was empty. There was no tiger.",
                correctionResponse: "Not this time. Look at the empty grass. Cole called Tiger, but no tiger was there."
            ),
            StoryQuestion(
                id: "q2-ranchers-feel",
                referencedPageID: "page-03",
                prompt: "How did Mara and Ben feel when Cole laughed?",
                choices: [
                    choice("worried", "Worried", "exclamationmark.bubble.fill", true, "Worried"),
                    choice("amused", "Amused", "face.smiling.fill", false, "Amused")
                ],
                correctResponse: "Yes. They felt worried because they had hurried to help.",
                correctionResponse: "Look at their faces. They were worried, not amused."
            ),
            StoryQuestion(
                id: "q3-tiger-arrives",
                referencedPageID: "page-06",
                prompt: "What came out of the tall grass later?",
                choices: [
                    choice("tiger", "A tiger", "pawprint.fill", true, "A tiger"),
                    choice("calf", "A calf", "hare.fill", false, "A calf")
                ],
                correctResponse: "Yes. A real tiger came out of the grass.",
                correctionResponse: "Look beside the tall grass. The striped animal is the tiger."
            ),
            StoryQuestion(
                id: "q4-lesson",
                referencedPageID: "page-10",
                prompt: "What does Cole's story teach us to do?",
                choices: [
                    choice("tell-truth", "Tell the truth", "checkmark.seal.fill", true, "Tell the truth"),
                    choice("call-joke", "Call danger as a joke", "megaphone.fill", false, "Call danger as a joke")
                ],
                correctResponse: "That's right. Telling the truth helps people trust us.",
                correctionResponse: "Calling danger as a joke made it hard to know when Cole needed help. The lesson is to tell the truth."
            )
        ]
    )

    private static func page(
        _ order: Int,
        _ title: String,
        _ text: String,
        _ altText: String,
        _ artKind: StoryArtKind
    ) -> StoryPage {
        let id = String(format: "page-%02d", order)
        return StoryPage(
            id: id,
            order: order,
            imageAsset: String(format: "page-%02d", order),
            displayedText: text,
            narrationTranscript: text,
            altText: altText,
            artKind: artKind
        )
    }

    private static func choice(
        _ id: String,
        _ label: String,
        _ symbol: String,
        _ isCorrect: Bool,
        _ accessibilityLabel: String
    ) -> StoryChoice {
        StoryChoice(
            id: id,
            label: label,
            symbol: symbol,
            isCorrect: isCorrect,
            accessibilityLabel: accessibilityLabel
        )
    }
}
