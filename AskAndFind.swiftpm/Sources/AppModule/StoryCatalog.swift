import Foundation

enum StoryCatalog {
    static let cowboyWhoCriedTiger = StoryBook(
        id: "cowboy-who-cried-tiger",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Cowboy Who Cried Tiger",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "The Ranch", "Cole was a cowboy. Each day, he watched the calves near the tall grass while the other ranchers worked nearby.", "Wide ranch view with Cole on a fence, calves in the middle, and two ranchers repairing a gate."),
            page(2, "The First Lie", "One quiet afternoon, Cole felt bored. He shouted, “Tiger! Tiger! Please help!” But there was no tiger.", "Cole calls toward empty tall grass while the ranch and calves remain safe behind him."),
            page(3, "The Joke", "Mara and Ben hurried to Cole. Cole laughed. “I fooled you!” The ranchers felt worried, not amused.", "Two ranchers arrive with calm concern while Cole laughs beside the fence."),
            page(4, "The Second Lie", "The next day, Cole called “Tiger!” again. Again, the ranchers ran to help. Again, there was no tiger.", "Cole calls near a water trough as the ranchers approach and the grass stays empty."),
            page(5, "The Warning", "“Only call when danger is real,” Mara said. “If you keep lying, we may not believe you.”", "Mara speaks gently at Cole’s eye level while Ben listens nearby."),
            page(6, "A Real Tiger", "Soon, the tall grass rustled. A real tiger crept toward Cole. This time, he was telling the truth.", "Cole sees a tiger emerging from distant grass, with plenty of safe space between them."),
            page(7, "No One Comes", "“Tiger! Please help!” Cole cried. The ranchers heard him, but they thought it was another trick.", "Cole calls from a far hill while the ranchers pause by the barn, unsure whether to believe him."),
            page(8, "The Consequence", "No one came in time. The tiger caught Cole and gobbled him up.", "An empty sunset field with Cole’s hat, bent grass, and tiger tracks. No attack, injury, or remains."),
            page(9, "The Ranchers Understand", "Later, Mara and Ben found Cole’s hat and the tiger tracks. They were sad that they had not known his warning was true.", "Mara holds Cole’s hat while Ben studies the tracks in soft evening light."),
            page(10, "The Lesson", "Telling the truth helps people trust us. If you are ever in danger, keep calling for a trusted grown-up.", "A comforting ranch sunrise with calves, a secure fence, and Cole’s hat hanging by the barn.")
        ],
        questions: [
            question("q1-first-call", "page-02", "Was there really a tiger the first time Cole called for help?", [
                choice("no-tiger", "No tiger", "leaf.fill", true),
                choice("real-tiger", "A real tiger", "pawprint.fill", false)
            ], "That’s right. The grass was empty. There was no tiger.", "Not this time. Look at the empty grass. Cole called Tiger, but no tiger was there."),
            question("q2-ranchers-feel", "page-03", "How did Mara and Ben feel when Cole laughed?", [
                choice("worried", "Worried", "exclamationmark.bubble.fill", true),
                choice("amused", "Amused", "face.smiling.fill", false)
            ], "Yes. They felt worried because they had hurried to help.", "Look at their faces. They were worried, not amused."),
            question("q3-tiger-arrives", "page-06", "What came out of the tall grass later?", [
                choice("tiger", "A tiger", "pawprint.fill", true),
                choice("calf", "A calf", "circle.fill", false)
            ], "Yes. A real tiger came out of the grass.", "Look beside the tall grass. The striped animal is the tiger."),
            question("q4-lesson", "page-10", "What does Cole’s story teach us to do?", [
                choice("tell-truth", "Tell the truth", "checkmark.seal.fill", true),
                choice("call-joke", "Call danger as a joke", "megaphone.fill", false)
            ], "That’s right. Telling the truth helps people trust us.", "Calling danger as a joke made it hard to know when Cole needed help. The lesson is to tell the truth.")
        ]
    )

    static let tortoiseAndHare = StoryBook(
        id: "tortoise-and-hare",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Tortoise and the Hare",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "The Meadow", "In a sunny meadow, Hugo the hare loved to run fast. Tessa the tortoise moved slowly, one steady step at a time.", "Hugo and Tessa meet beside a sunny woodland race path."),
            page(2, "The Challenge", "Hugo told everyone he was the fastest. Tessa smiled and said, ‘Let’s have a race.’", "Hugo and Tessa face one another beside the marked race path."),
            page(3, "Ready, Set, Go", "The forest friends marked a path. At the signal, Hugo dashed ahead while Tessa began calmly.", "Hugo starts running while Tessa takes her first steady step."),
            page(4, "Far Ahead", "Soon Hugo was far in front. He looked back and could barely see Tessa on the path.", "Hugo runs far ahead while Tessa remains on the winding path."),
            page(5, "Step by Step", "Tessa kept moving. Over the bridge and up the hill, she did not stop.", "Tessa steadily crosses a small bridge and climbs the meadow hill."),
            page(6, "A Quick Rest", "Hugo felt sure he would win. He rested beneath an oak tree and soon fell asleep.", "Hugo sleeps peacefully under the broad oak beside the race path."),
            page(7, "Passing By", "Tessa reached the oak. She walked quietly past sleeping Hugo and continued toward the finish.", "Tessa walks past sleeping Hugo under the oak."),
            page(8, "Wide Awake", "At last Hugo woke up. He saw Tessa near the finish and ran as fast as he could.", "Hugo wakes and sees Tessa near the finish ribbon."),
            page(9, "The Finish", "Tessa crossed the finish first. The forest friends cheered for her steady effort.", "Tessa crosses the finish ribbon as woodland friends cheer."),
            page(10, "The Lesson", "Hugo congratulated Tessa. He learned that speed is useful, but steady effort and finishing what we start matter too.", "Hugo congratulates Tessa beside the finish ribbon.")
        ],
        questions: [
            question("q1-invited-race", "page-02", "Who invited Hugo to race?", [
                choice("tessa", "Tessa", "tortoise.fill", true),
                choice("robin", "Robin", "bird.fill", false)
            ], "Yes. Tessa calmly invited Hugo to race.", "Look beside Hugo. Tessa the tortoise invited him to race."),
            question("q2-oak-tree", "page-06", "What did Hugo do beneath the oak tree?", [
                choice("fell-asleep", "Fell asleep", "moon.zzz.fill", true),
                choice("kept-running", "Kept running", "figure.run", false)
            ], "That’s right. Hugo stopped to rest and fell asleep.", "Look under the oak. Hugo is sleeping."),
            question("q3-finish-first", "page-09", "Who crossed the finish first?", [
                choice("tessa", "Tessa", "tortoise.fill", true),
                choice("hugo", "Hugo", "hare.fill", false)
            ], "Yes. Tessa crossed the finish first.", "Look at the ribbon. Tessa reached it first."),
            question("q4-steady-effort", "page-10", "What helped Tessa finish the race?", [
                choice("steady-effort", "Steady effort", "checkmark.circle.fill", true),
                choice("giving-up", "Giving up", "hand.raised.fill", false)
            ], "That’s right. Tessa kept going one steady step at a time.", "Tessa did not give up. Her steady effort helped her finish.")
        ]
    )

    static let lionAndMouse = StoryBook(
        id: "lion-and-mouse",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Lion and the Mouse",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "A Quiet Morning", "Leo the lion slept beneath an acacia tree. Nearby, Mina the mouse gathered seeds in the grass.", "Leo sleeps beneath an acacia tree while Mina gathers seeds nearby."),
            page(2, "A Surprise", "Mina hurried across Leo’s paw. Leo woke with a start and stopped her beside his great paw.", "Mina pauses beside Leo’s large paw as he wakes."),
            page(3, "A Promise", "‘Please let me go,’ Mina said. ‘Someday I may help you.’ Leo wondered how such a small mouse could help.", "Mina speaks bravely beside Leo while he listens with curiosity."),
            page(4, "Kindness", "Leo chose to be kind and let Mina go. Mina thanked him and hurried home.", "Mina leaves safely while Leo watches kindly."),
            page(5, "The Rope Net", "Later, a heavy rope net fell around Leo. He pulled, but the ropes only tightened.", "Leo is safely shown inside a rope net on the savanna, with no injury or frightening attack."),
            page(6, "Mina Hears", "Leo called across the savanna. Mina recognized his voice and hurried to help.", "Mina approaches Leo and the net across the golden grass."),
            page(7, "Small Teeth, Big Help", "Mina worked at one knot, then another. Her tiny teeth loosened the strong ropes.", "Mina works carefully at a rope knot while Leo waits calmly."),
            page(8, "Free Again", "At last the net opened. Leo stepped out, safe and free.", "Leo and Mina walk safely together after the loosened net."),
            page(9, "Thank You", "Leo thanked Mina. Now he understood that being small did not mean being unable to help.", "Mina stands beside the loosened knot while Leo is free in the distance."),
            page(10, "The Lesson", "Leo and Mina became true friends. Kindness matters, and help can come in every size.", "Lion and mouse footprints travel side by side toward a warm savanna sunrise.")
        ],
        questions: [
            question("q1-woke-leo", "page-02", "Who woke Leo?", [
                choice("mina", "Mina", "mouse.fill", true),
                choice("bird", "A bird", "bird.fill", false)
            ], "Yes. Mina the mouse woke Leo.", "Look beside Leo’s paw. Mina the mouse woke him."),
            question("q2-kind-choice", "page-04", "What did Leo choose to do?", [
                choice("let-go", "Let Mina go", "hand.thumbsup.fill", true),
                choice("keep-there", "Keep her there", "hand.raised.fill", false)
            ], "That’s right. Leo chose kindness and let Mina go.", "Look at Mina leaving safely. Leo let her go."),
            question("q3-helped-leo", "page-07", "How did Mina help Leo?", [
                choice("loosened-ropes", "Loosened the ropes", "link", true),
                choice("ran-away", "Ran away", "figure.run", false)
            ], "Yes. Mina loosened the rope knots.", "Look at the knot. Mina is loosening the ropes."),
            question("q4-story-teach", "page-10", "What does the story teach us?", [
                choice("anyone-help", "Anyone can help", "person.2.fill", true),
                choice("only-big", "Only big animals help", "arrow.up.circle.fill", false)
            ], "That’s right. Help can come in every size.", "Mina was tiny and still helped Leo. Anyone can help.")
        ]
    )

    static let foxAndGrapes = StoryBook(
        id: "fox-and-grapes",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Fox and the Grapes",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "The Vineyard", "Felix the fox walked through a sunny vineyard. Above him hung a beautiful bunch of purple grapes.", "Felix notices purple grapes hanging above a sunny vineyard path."),
            page(2, "A Tasty Wish", "The grapes looked cool and juicy. Felix stretched up, but they were much too high.", "Felix stretches toward grapes high above the vineyard path."),
            page(3, "The First Jump", "Felix jumped with all his might. He landed safely, but the grapes stayed out of reach.", "Felix makes a safe first jump toward the high grapes."),
            page(4, "Another Idea", "He climbed onto a low stump and reached again. His paws still could not touch the grapes.", "Felix reaches from a low stump but remains short of the grapes."),
            page(5, "One More Try", "Felix took a running start and leaped. He came close, but not close enough.", "Felix makes another safe running leap beneath the grape arbor."),
            page(6, "Disappointed", "Felix sat in the shade to catch his breath. He felt tired and disappointed.", "Felix rests calmly in the shade, feeling disappointed."),
            page(7, "Pretending", "‘Those grapes are probably sour anyway,’ Felix said, even though he had wanted them very much.", "Felix looks away beneath the arbor while the ripe grapes remain above."),
            page(8, "Walking Away", "Felix walked away with his nose in the air. Pretending made his disappointment no smaller.", "Felix walks away while glancing back at the grape arbor."),
            page(9, "An Honest Feeling", "Felix paused. ‘I am disappointed because I could not reach them,’ he admitted.", "Felix pauses beside the stone wall and honestly recognizes his feeling."),
            page(10, "The Lesson", "It is okay to feel disappointed. We can tell the truth about our feelings, try again later, or ask for help.", "Felix walks toward home at sunset, looking back peacefully at the vineyard.")
        ],
        questions: [
            question("q1-felix-wanted", "page-02", "What did Felix want?", [
                choice("purple-grapes", "Purple grapes", "circle.fill", true),
                choice("red-apple", "A red apple", "circle.fill", false)
            ], "Yes. Felix wanted the purple grapes.", "Look above Felix. He wanted the purple grapes."),
            question("q2-reach-grapes", "page-05", "Could Felix reach the grapes?", [
                choice("no", "No", "xmark.circle.fill", true),
                choice("yes", "Yes", "checkmark.circle.fill", false)
            ], "That’s right. Felix tried, but he could not reach them.", "Look at the space above his paws. The grapes were still too high."),
            question("q3-what-said", "page-07", "What did Felix say about the grapes?", [
                choice("probably-sour", "They were probably sour", "bubble.left.fill", true),
                choice("easy-reach", "They were easy to reach", "hand.point.up.fill", false)
            ], "Yes. Felix said they were probably sour.", "Felix could not reach them, so he pretended they were probably sour."),
            question("q4-disappointed", "page-10", "What can we do when we feel disappointed?", [
                choice("truth-next-step", "Tell the truth and choose a next step", "checkmark.seal.fill", true),
                choice("pretend", "Pretend we never wanted it", "theatermasks.fill", false)
            ], "That’s right. We can name the feeling and choose what to do next.", "It is okay to say, ‘I feel disappointed,’ and then try later or ask for help.")
        ]
    )

    static let allBooks: [StoryBook] = [
        cowboyWhoCriedTiger,
        tortoiseAndHare,
        lionAndMouse,
        foxAndGrapes
    ]

    static func book(id: String) -> StoryBook? {
        allBooks.first { $0.id == id }
    }

    static var validationIssues: [String] {
        var issues: [String] = []
        let ids = allBooks.map(\.id)
        if Set(ids).count != ids.count {
            issues.append("Story IDs must be unique.")
        }
        for book in allBooks where !book.isValid {
            issues.append("Invalid story content: \(book.id)")
        }
        return issues
    }

    private static func page(
        _ order: Int,
        _ title: String,
        _ text: String,
        _ altText: String
    ) -> StoryPage {
        let id = String(format: "page-%02d", order)
        return StoryPage(
            id: id,
            order: order,
            title: title,
            imageAsset: id,
            displayedText: text,
            narrationTranscript: text,
            altText: altText
        )
    }

    private static func question(
        _ id: String,
        _ referencedPageID: String,
        _ prompt: String,
        _ choices: [StoryChoice],
        _ correctResponse: String,
        _ correctionResponse: String
    ) -> StoryQuestion {
        StoryQuestion(
            id: id,
            referencedPageID: referencedPageID,
            prompt: prompt,
            choices: choices,
            correctResponse: correctResponse,
            correctionResponse: correctionResponse
        )
    }

    private static func choice(
        _ id: String,
        _ label: String,
        _ symbol: String,
        _ isCorrect: Bool
    ) -> StoryChoice {
        StoryChoice(
            id: id,
            label: label,
            symbol: symbol,
            isCorrect: isCorrect,
            accessibilityLabel: label
        )
    }
}
