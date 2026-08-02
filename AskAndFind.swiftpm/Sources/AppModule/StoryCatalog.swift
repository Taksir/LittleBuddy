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

    static let antAndDove = StoryBook(
        id: "ant-and-dove",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Ant and the Dove",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "A Splashing Ant", "A tiny ant slipped on a muddy riverbank and fell into the swirling river.", "A tiny ant slipping into swirling river water near a muddy bank."),
            page(2, "Swept Away", "The strong water spun the ant around as she tried to stay floating.", "The ant struggling to float in rushing blue river water."),
            page(3, "A Watching Dove", "High in a green tree, a kind white dove saw the ant and wanted to help.", "A plump white dove watching the ant from a leafy tree branch."),
            page(4, "The Floating Leaf", "The clever dove picked a green leaf with her beak and dropped it down to the water.", "The dove dropping a green leaf down toward the river."),
            page(5, "Safe Ashore", "The ant climbed onto the leaf and floated safely to dry grass.", "The ant floating safely on the green leaf to dry shore."),
            page(6, "The Hunter", "The next morning, a hunter crept near the tree with a big net aimed at the dove.", "A hunter with a big net creeping toward the sleeping dove."),
            page(7, "Ready to Help", "The thankful ant saw the hunter and ran quickly across the ground.", "The ant sprinting across the grass toward the hunter."),
            page(8, "A Tiny Bite", "The ant bit the hunter’s heel as hard as she could.", "The ant biting the hunter's bare heel on the grass."),
            page(9, "Surprise!", "The hunter shouted 'Ouch!' and dropped his big net.", "The hunter jumping up, yelling ouch, and dropping his net."),
            page(10, "Flying Free", "The dove woke up, flapped her wings, and flew safely into the blue sky.", "The white dove flying safely into the bright sky above.")
        ],
        questions: [
            question("q1-leaf-drop", "page-04", "What did the dove drop into the water to help the ant?", [
                choice("green-leaf", "A green leaf", "leaf.fill", true),
                choice("small-pebble", "A small pebble", "circle.fill", false)
            ], "That’s right! The dove dropped a green leaf into the river.", "Look at the dove. She dropped a green leaf to save the ant."),
            question("q2-safe-shore", "page-05", "How did the ant get safely back to shore?", [
                choice("floated-leaf", "Floated on the leaf", "leaf.fill", true),
                choice("swam-fast", "Swam across", "figure.pool.swim", false)
            ], "Yes! The ant climbed onto the leaf and floated to shore.", "The ant climbed on the floating leaf to reach dry grass."),
            question("q3-stop-hunter", "page-08", "How did the ant stop the hunter?", [
                choice("bit-heel", "Bit his heel", "pawprint.fill", true),
                choice("called-help", "Called for help", "megaphone.fill", false)
            ], "Yes! The ant bit the hunter’s heel as hard as she could.", "Look at the hunter's foot. The ant bit his heel to stop him."),
            question("q4-moral-kindness", "page-10", "What does this story teach us about kindness?", [
                choice("kindness-helps", "When you are kind, others will help you too", "heart.fill", true),
                choice("birds-leaves", "Birds like green leaves", "leaf.circle.fill", false)
            ], "That’s right! Being kind helps everyone.", "The ant saved the dove because the dove helped her first. Kindness matters!")
        ]
    )

    static let antAndGrasshopper = StoryBook(
        id: "ant-and-grasshopper",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Ant and the Grasshopper",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "Busy Ants", "All summer long, busy ants worked together to carry seeds and food to their anthill.", "Line of ants carrying heavy seeds toward their anthill."),
            page(2, "Playing Music", "A bright green grasshopper sat on a flower, playing his fiddle in the warm sun.", "A green grasshopper playing a tiny fiddle on a flower."),
            page(3, "Summer Days", "While the ants marched and gathered food, the grasshopper hopped and sang all day.", "Ants marching on the left while the grasshopper plays on the right."),
            page(4, "Hard Work", "One ant worked very hard pulling a heavy piece of corn across the grass.", "A single ant pulling a large piece of corn over a twig."),
            page(5, "Resting", "The grasshopper rested lazily and watched the hard-working ant trudge by.", "The grasshopper lounging on a dandelion while watching the ant."),
            page(6, "Autumn Leaves", "When autumn came, orange leaves fell. The ants gathered the last food into their warm home.", "Fallen autumn leaves around the anthill as ants carry food inside."),
            page(7, "First Frost", "Cold frost covered the grass. The ants were safe inside, and the music stopped.", "Frosty grass with no ants in sight and a discarded fiddle."),
            page(8, "Cold and Hungry", "The grasshopper shivered in the snow, wishing he had saved food for winter.", "The grasshopper shivering in snow next to a frozen acorn."),
            page(9, "Knocking for Help", "The grasshopper knocked at the anthill door to ask the ants for help.", "The grasshopper shivering and knocking at the anthill door."),
            page(10, "Warm and Safe", "Inside, the ants were cozy and fed. Planning ahead helps us stay safe and warm.", "Inside the cozy anthill with stacked food and warm fire.")
        ],
        questions: [
            question("q1-summer-ants", "page-01", "What were the ants doing during the summer?", [
                choice("gathering-food", "Gathering food", "leaf.fill", true),
                choice("sleeping-grass", "Sleeping in the grass", "moon.zzz.fill", false)
            ], "That’s right! The ants worked together to gather food all summer.", "Look at the ants in line. They were carrying seeds into their home."),
            question("q2-grasshopper-music", "page-02", "What did the grasshopper do all summer?", [
                choice("played-fiddle", "Played his fiddle", "music.note", true),
                choice("built-house", "Built a house", "house.fill", false)
            ], "Yes! The grasshopper sat on a flower and played his fiddle.", "Look at the green grasshopper. He played music in the sun."),
            question("q3-hungry-winter", "page-08", "Why was the grasshopper hungry in the winter?", [
                choice("no-food-saved", "He didn't save any food", "xmark.circle.fill", true),
                choice("lost-fiddle", "He lost his fiddle", "music.note.slash", false)
            ], "Yes! He sang all summer and did not save food for winter.", "The grasshopper did not save food when it was sunny, so he had none in winter."),
            question("q4-plan-ahead", "page-10", "What lesson does the story teach us?", [
                choice("plan-ahead", "Work and plan ahead for the future", "checkmark.seal.fill", true),
                choice("only-play", "Only play music every day", "sparkles", false)
            ], "That’s right! Planning ahead keeps us safe and prepared.", "The ants were warm and safe because they worked ahead. It is important to plan!")
        ]
    )

    static let crowAndPitcher = StoryBook(
        id: "crow-and-pitcher",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Crow and the Pitcher",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "A Thirsty Crow", "On a hot summer day, a thirsty crow searched for water across the dry land.", "A crow flying under a blazing hot sun looking for water."),
            page(2, "Finding a Pitcher", "She spotted a tall glass pitcher standing on a table with water inside.", "A tall glass pitcher with water inside standing on a wooden table."),
            page(3, "Out of Reach", "The water was at the bottom, but the pitcher’s neck was too narrow for her beak.", "The crow peering into the narrow neck of the pitcher."),
            page(4, "Trying Hard", "She pushed her head down, but the water was still out of reach.", "The crow trying to reach down into the pitcher."),
            page(5, "Too Heavy", "The crow tried to tip the heavy pitcher over, but it would not budge.", "The crow pushing against the heavy glass pitcher."),
            page(6, "Taking a Rest", "Tired and thirsty, she sat beside the pitcher to think.", "The crow resting thoughtfully on the ground near the table."),
            page(7, "A Bright Idea", "She saw small pebbles on the ground and came up with a clever plan.", "The crow looking at a pile of pebbles near the garden path."),
            page(8, "One by One", "The crow picked up a pebble and dropped it into the pitcher.", "The crow dropping a pebble into the top of the pitcher."),
            page(9, "Water Rising", "Pebble by pebble, the stones filled the bottom and pushed the water higher.", "Pebbles filling the bottom of the pitcher as water rises to the top."),
            page(10, "A Cool Drink", "At last, the water reached the top, and the clever crow drank her fill.", "The happy crow drinking water from the brim of the pitcher.")
        ],
        questions: [
            question("q1-narrow-neck", "page-03", "Why couldn't the crow drink water at first?", [
                choice("neck-narrow", "The pitcher neck was too narrow", "arrow.up.and.down", true),
                choice("pitcher-empty", "The pitcher was empty", "xmark.bin", false)
            ], "That’s right! The neck was too narrow for her beak to reach the water.", "Look inside the pitcher. The water was deep down and the neck was too narrow."),
            question("q2-pebble-plan", "page-07", "What did the crow spot on the ground?", [
                choice("small-pebbles", "Small pebbles", "circle.grid.cross.fill", true),
                choice("big-sticks", "Big sticks", "line.diagonal", false)
            ], "Yes! The crow saw small pebbles on the garden path.", "The crow saw small pebbles that she could pick up with her beak."),
            question("q3-water-rose", "page-09", "What happened when the crow dropped pebbles in?", [
                choice("water-rose", "The water rose higher", "arrow.up.circle.fill", true),
                choice("pitcher-broke", "The pitcher broke", "exclamationmark.triangle.fill", false)
            ], "Yes! Each pebble pushed the water higher to the top.", "Dropping pebbles inside made the water rise up so the crow could reach it."),
            question("q4-clever-crow", "page-10", "What does the crow’s story teach us?", [
                choice("clever-thinking", "Clever thinking and patience solve hard problems", "brain.head.profile", true),
                choice("give-up-easy", "Give up when things are hard", "hand.raised.fill", false)
            ], "That’s right! Patience and clever thinking solve hard problems.", "The crow did not give up. She thought of a smart plan and solved her problem!")
        ]
    )

    static let townMouseAndCountryMouse = StoryBook(
        id: "town-mouse-and-country-mouse",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Town Mouse and the Country Mouse",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "A Quiet Home", "Barnaby the country mouse lived in a peaceful, quiet meadow home.", "Barnaby the country mouse sitting inside a cozy wooden barn home."),
            page(2, "A Friendly Visit", "His cousin Timothy, a town mouse, came to visit the countryside.", "Barnaby welcoming his town mouse cousin Timothy outside the barn."),
            page(3, "Simple Meal", "Barnaby served acorns and grain, but Timothy wanted fancy food.", "Barnaby serving acorns and grain on a small wooden table."),
            page(4, "Invited to Town", "Timothy invited Barnaby to see his grand town home.", "Timothy gesturing toward the city path inviting Barnaby along."),
            page(5, "Grand Dining Room", "They arrived at a grand dining room full of cheese, cakes, and berries.", "Both mice looking at a grand dining table covered in cakes and cheese."),
            page(6, "A Tasty Feast", "Barnaby nibbled a sweet crumb, enjoying the delicious feast.", "Barnaby enjoying a sweet cake crumb on top of the dining table."),
            page(7, "A Sudden Danger", "Suddenly, a big cat shadow appeared and heavy footsteps startled them.", "The mice looking up in surprise as a soft cat shadow appears."),
            page(8, "Running to Hide", "The mice scampered quickly into a small wall hole to stay safe.", "The mice running into a small safe hole in the wall baseboard."),
            page(9, "Quiet Reflection", "Barnaby realized that fancy food was not worth constant danger.", "Barnaby realizing inside the mouse hole that quiet safety is best."),
            page(10, "Home Safe", "Barnaby returned to his peaceful meadow, happy and safe at home.", "Barnaby back in his country home holding an acorn happily.")
        ],
        questions: [
            question("q1-country-food", "page-03", "What food did Barnaby serve in the country?", [
                choice("acorns-grain", "Acorns and grain", "leaf.fill", true),
                choice("cake-pie", "Cake and pie", "birthday.cake.fill", false)
            ], "That’s right! Barnaby served simple acorns and grain.", "Look at the table. Barnaby served acorns and grain."),
            question("q2-town-visit", "page-05", "Where did Timothy take Barnaby?", [
                choice("grand-town-home", "To a grand town home", "house.fill", true),
                choice("farm-barn", "To a farm barn", "building.fill", false)
            ], "Yes! Timothy invited Barnaby to his grand town home.", "They traveled to the town to see the grand dining room."),
            question("q3-scared-mice", "page-07", "Why did the mice run away during the feast?", [
                choice("cat-shadow", "A cat shadow startled them", "pawprint.fill", true),
                choice("rain-storm", "It started to rain", "cloud.rain.fill", false)
            ], "Yes! A big cat shadow appeared and startled the mice.", "Look at the wall. The cat shadow made the mice hide."),
            question("q4-peaceful-life", "page-10", "What lesson did Barnaby learn?", [
                choice("peace-is-best", "A peaceful simple life is best", "heart.fill", true),
                choice("eat-fast", "Always eat as fast as you can", "bolt.fill", false)
            ], "That’s right! Quiet safety is better than luxury with danger.", "Barnaby was happy to return to his calm meadow home.")
        ]
    )

    static let dogAndHisReflection = StoryBook(
        id: "dog-and-his-reflection",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Dog and His Reflection",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "A Happy Dog", "Barnaby the friendly dog found a tasty bone at the market.", "Barnaby the dog carrying a big bone proudly."),
            page(2, "Walking Home", "He held the bone proudly in his mouth as he walked home.", "Barnaby walking along a sunny meadow path with his bone."),
            page(3, "Crossing the Bridge", "He stepped onto a small wooden bridge over a clear stream.", "Barnaby stepping onto a small wooden bridge over water."),
            page(4, "Looking Down", "Looking into the water, he saw another dog carrying a bone.", "Barnaby looking down into the stream at his reflection."),
            page(5, "A Water Mirror", "He did not know it was only his own reflection in the calm water.", "The calm water reflecting Barnaby and his bone."),
            page(6, "Wanting More", "Barnaby felt greedy and wanted the other dog's bone too.", "Barnaby looking greedily at the reflection in the water."),
            page(7, "Barking", "He opened his mouth to bark at the reflection in the stream.", "Barnaby opening his mouth to bark at the stream."),
            page(8, "Splash!", "His own bone fell from his mouth and splashed into the water.", "The bone dropping into the stream with a water splash."),
            page(9, "The Realization", "The water rippled and the other dog disappeared.", "Barnaby watching water ripples as the reflection fades."),
            page(10, "The Lesson", "Barnaby learned to be thankful for what he has instead of being greedy.", "Barnaby sitting peacefully on the riverbank learning to be thankful.")
        ],
        questions: [
            question("q1-found-bone", "page-01", "What did Barnaby the dog find at the market?", [
                choice("tasty-bone", "A tasty bone", "bone.fill", true),
                choice("red-ball", "A red ball", "circle.fill", false)
            ], "That’s right! Barnaby found a tasty bone.", "Look in his mouth. Barnaby found a big bone."),
            question("q2-saw-water", "page-04", "What did Barnaby see when he looked into the stream?", [
                choice("another-dog", "Another dog with a bone", "pawprint.fill", true),
                choice("swimming-fish", "A swimming fish", "fish.fill", false)
            ], "Yes! He saw his reflection, which looked like another dog.", "Looking into the calm water showed his own reflection."),
            question("q3-barked-splash", "page-08", "What happened when Barnaby opened his mouth to bark?", [
                choice("bone-fell", "His bone fell into the water", "drop.fill", true),
                choice("got-two-bones", "He got a second bone", "plus.circle.fill", false)
            ], "Yes! When he opened his mouth, his bone fell into the stream.", "Opening his mouth made his own bone drop into the water."),
            question("q4-thankful-lesson", "page-10", "What did Barnaby learn at the end?", [
                choice("be-thankful", "Be thankful for what you have", "heart.fill", true),
                choice("bark-louder", "Bark louder at the water", "megaphone.fill", false)
            ], "That’s right! Being happy with what we have prevents greedy loss.", "Barnaby learned to appreciate the things he already has.")
        ]
    )

    static let foxAndCrow = StoryBook(
        id: "fox-and-crow",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Fox and the Crow",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "A Piece of Cheese", "Clara the crow found a nice piece of yellow cheese on a porch.", "Clara the crow finding a wedge of yellow cheese."),
            page(2, "Perched in a Tree", "She flew up to a tall branch to enjoy her food in peace.", "Clara perched on an oak branch holding cheese in her beak."),
            page(3, "A Clever Fox", "Sly the fox smelled the cheese and walked over to the tree.", "Sly the fox walking near the base of the oak tree."),
            page(4, "Looking Up", "Sly wanted the cheese, so he thought of a clever plan.", "Sly looking up toward Clara on the high branch."),
            page(5, "Sweet Words", "Sly spoke softly, praising Clara's beautiful dark feathers.", "Sly speaking politely and praising Clara's feathers."),
            page(6, "More Flattery", "He told Clara that her voice must be the sweetest in the forest.", "Sly looking up admiringly at the crow."),
            page(7, "Singing out Loud", "Pleased by the praise, Clara opened her beak to sing a song.", "Clara opening her beak to sing a loud song."),
            page(8, "The Cheese Falls", "The cheese dropped from her beak and tumbled down through the leaves.", "The cheese falling down from Clara's beak through the leaves."),
            page(9, "Caught on the Ground", "Sly caught the cheese safely on the grass and thanked Clara.", "Sly catching the cheese on the grass below."),
            page(10, "The Lesson", "Clara learned to think carefully before believing flattery.", "Clara perching thoughtfully, learning to be careful of flattery.")
        ],
        questions: [
            question("q1-crow-cheese", "page-01", "What did Clara the crow find?", [
                choice("yellow-cheese", "A piece of yellow cheese", "square.fill", true),
                choice("red-apple", "A red apple", "apple.fill", false)
            ], "That’s right! Clara found a piece of yellow cheese.", "Look in her beak. Clara found a piece of cheese."),
            question("q2-fox-praise", "page-05", "What did Sly the fox praise about Clara?", [
                choice("feathers-voice", "Her feathers and voice", "sparkles", true),
                choice("fast-flying", "Her fast flying", "wind", false)
            ], "Yes! Sly praised her dark feathers and sweet voice.", "Sly used sweet words to flatter her feathers and voice."),
            question("q3-cheese-dropped", "page-08", "What happened when Clara opened her beak to sing?", [
                choice("cheese-fell", "The cheese fell down", "arrow.down.circle.fill", true),
                choice("sang-song", "The cheese stayed put", "music.note", false)
            ], "Yes! Opening her beak made the cheese fall to the ground.", "When she opened her beak, the cheese dropped down."),
            question("q4-flattery-lesson", "page-10", "What lesson did Clara learn?", [
                choice("think-carefully", "Think carefully before trusting flattery", "brain.head.profile", true),
                choice("sing-louder", "Sing whenever asked", "megaphone.fill", false)
            ], "That’s right! Be careful when praise is used to trick you.", "Clara learned to pause and think before believing empty flattery.")
        ]
    )

    static let gooseAndGoldenEggs = StoryBook(
        id: "goose-and-golden-eggs",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Goose That Laid the Golden Eggs",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "The Special Farm", "Farmer Giles lived on a small, sunny cottage farm.", "Farmer Giles standing near his sunny cottage farm."),
            page(2, "A Golden Surprise", "One morning, his white goose laid a bright golden egg.", "A white goose sitting in a nest beside a golden egg."),
            page(3, "Pure Joy", "Giles held the shiny golden egg with wonder and delight.", "Farmer Giles holding a shiny golden egg with joy."),
            page(4, "Every Morning", "Each day, the goose laid one more beautiful golden egg.", "The goose laying a golden egg every morning in the barn."),
            page(5, "Growing Wealthy", "The farmer had plenty of food and clothes from selling the eggs.", "Farmer Giles enjoying good food and clothes at home."),
            page(6, "Getting Impatient", "Soon, Giles grew impatient and wished for all the gold at once.", "Giles looking impatiently at the goose in the nest."),
            page(7, "A Careless Decision", "He crowded the goose's nest and tried to rush her laying.", "Giles crowding near the nest trying to hurry the goose."),
            page(8, "Scared Away", "Frightened by his impatience, the goose flew over the fence to a quiet meadow.", "The white goose flying over the fence to a quiet meadow."),
            page(9, "An Empty Nest", "Giles looked at the empty nest and felt sorry for his greed.", "Giles looking sorrowfully at the empty straw nest."),
            page(10, "The Lesson", "Giles learned that patience and care protect valuable blessings.", "Giles standing peacefully learning that patience protects blessings.")
        ],
        questions: [
            question("q1-golden-egg", "page-02", "What special thing did the goose lay?", [
                choice("golden-egg", "A golden egg", "sparkles", true),
                choice("silver-feather", "A silver feather", "leaf.fill", false)
            ], "That’s right! The goose laid a bright golden egg.", "Look in the nest. The goose laid a golden egg."),
            question("q2-how-often", "page-04", "How often did the goose lay a golden egg?", [
                choice("every-morning", "Every morning", "sun.max.fill", true),
                choice("once-year", "Once a year", "calendar", false)
            ], "Yes! The goose laid one golden egg every single morning.", "Each morning brought one new golden egg."),
            question("q3-goose-flew", "page-08", "Why did the goose fly away to the meadow?", [
                choice("frightened-impatient", "The farmer's impatience frightened her", "exclamationmark.triangle.fill", true),
                choice("wanted-swim", "She wanted to swim in the pond", "figure.pool.swim", false)
            ], "Yes! Giles crowded her nest and frightened her away.", "Impatient rushing scared the goose into flying to a quiet meadow."),
            question("q4-patience-lesson", "page-10", "What lesson did Farmer Giles learn?", [
                choice("patience-protects", "Patience and care protect valuable blessings", "heart.fill", true),
                choice("rush-fast", "Rush as fast as you can", "bolt.fill", false)
            ], "That’s right! Patience and care preserve the good things we have.", "Giles learned that greed and impatience destroy good blessings.")
        ]
    )

    static let northWindAndSun = StoryBook(
        id: "north-wind-and-sun",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The North Wind and the Sun",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "Sky Friends", "The North Wind blew cold air while the Sun shone warmly in the sky.", "The North Wind cloud and warm Sun in the sky above."),
            page(2, "A Friendly Contest", "They saw a traveler wearing a cozy cloak walking along a path.", "A traveler wearing a warm cloak walking on a path below."),
            page(3, "The Challenge", "They agreed to see who could make the traveler remove his cloak.", "The Wind and Sun looking at the traveler's cloak."),
            page(4, "The Wind's Turn", "The North Wind blew hard, puffing his cheeks with icy gusts.", "The North Wind blowing icy wind gusts at the traveler."),
            page(5, "Wrapping Tighter", "The harder the wind blew, the tighter the traveler pulled his cloak.", "The traveler pulling his cloak tight against the cold wind."),
            page(6, "Giving Up", "The Wind blew until he was tired, but the cloak stayed on.", "The Wind tiring out while the cloak stays on tight."),
            page(7, "The Sun's Turn", "Then the Sun smiled and sent soft, warm rays down onto the path.", "The Sun beaming warm golden rays onto the traveler."),
            page(8, "Warming Up", "The traveler felt pleasantly warm and unbuttoned his heavy cloak.", "The traveler feeling pleasantly warm in the sunshine."),
            page(9, "Taking it Off", "Feeling comfortable in the sunshine, he took off his cloak to carry it.", "The traveler carrying his cloak comfortably on his arm."),
            page(10, "The Lesson", "The Wind smiled at the Sun. Gentleness can accomplish more than force.", "The Wind and Sun smiling down gently at the peaceful path.")
        ],
        questions: [
            question("q1-contest-goal", "page-03", "What did the Wind and Sun try to make the traveler do?", [
                choice("remove-cloak", "Remove his cloak", "tshirt.fill", true),
                choice("put-hat", "Put on a hat", "hand.raised.fill", false)
            ], "That’s right! They tried to see who could make him remove his cloak.", "The challenge was to get the traveler to take off his cloak."),
            question("q2-wind-blew", "page-05", "What did the traveler do when the Wind blew hard?", [
                choice("pulled-tighter", "Pulled his cloak tighter", "lock.fill", true),
                choice("blew-away", "Let the cloak blow away", "wind", false)
            ], "Yes! The cold wind made the traveler pull his cloak tighter.", "Blowing hard only made him wrap up tighter."),
            question("q3-sun-warmed", "page-09", "How did the Sun make the traveler take off his cloak?", [
                choice("warm-rays", "With soft warm sunshine", "sun.max.fill", true),
                choice("loud-thunder", "With loud thunder", "bolt.fill", false)
            ], "Yes! Gentle warm rays made the traveler feel comfortable.", "The Sun's warm light gently encouraged him to remove his cloak."),
            question("q4-gentleness-lesson", "page-10", "What lesson does the story teach us?", [
                choice("gentleness-stronger", "Gentleness is stronger than force", "heart.fill", true),
                choice("blowing-works", "Blowing hard works best", "wind", false)
            ], "That’s right! Soft gentleness accomplishes more than harsh force.", "Gentleness and warmth succeed where force fails.")
        ]
    )

    static let bundleOfSticks = StoryBook(
        id: "bundle-of-sticks",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Bundle of Sticks",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "The Forest Family", "Three young bear brothers lived together in a cozy forest cabin.", "Three bear brothers sitting in a cozy forest cabin."),
            page(2, "Working Apart", "They often squabbled over chores instead of helping each other.", "The bear brothers squabbling over chores in the yard."),
            page(3, "Wise Father", "Their wise father bear wanted to teach them a lesson about unity.", "Father bear speaking kindly to his three young sons."),
            page(4, "Single Sticks", "He gave each brother one thin wooden stick from the yard.", "Father bear handing a single wooden stick to each brother."),
            page(5, "Breaking Easily", "“Break it,” he said. Snap! Each single stick broke easily in half.", "Each single stick snapping easily in two."),
            page(6, "Tying a Bundle", "Father bear gathered seven sticks and tied them tightly with string.", "Father bear tying seven sticks together with string."),
            page(7, "Trying to Break", "He handed the bundle to the brothers and asked them to break it.", "The brothers trying to bend the bundle of sticks together."),
            page(8, "Unbroken", "Each brother tried with all his strength, but the bundle stayed solid.", "The solid bundle staying completely whole and unbroken."),
            page(9, "Understanding", "Father bear explained: “Together, you are strong like the bundle.”", "Father bear explaining unity while the brothers listen."),
            page(10, "Working Together", "The brothers held hands and agreed to cooperate and stay united.", "The three brothers holding hands happily in the yard.")
        ],
        questions: [
            question("q1-single-stick", "page-05", "What happened when the brothers tried to break a single stick?", [
                choice("broke-easily", "It broke easily", "xmark.circle.fill", true),
                choice("stayed-whole", "It stayed whole", "checkmark.circle.fill", false)
            ], "That’s right! One single stick broke easily in half.", "A single stick snaps easily when pulled."),
            question("q2-tied-bundle", "page-06", "What did father bear do with seven sticks?", [
                choice("tied-bundle", "Tied them into a tight bundle", "link", true),
                choice("built-fire", "Built a campfire", "flame.fill", false)
            ], "Yes! He tied seven sticks together into a strong bundle.", "He bound the sticks together with string."),
            question("q3-bundle-result", "page-08", "Could the brothers break the bundle of sticks?", [
                choice("bundle-solid", "No, it stayed solid and strong", "shield.fill", true),
                choice("snapped-fast", "Yes, it snapped fast", "bolt.fill", false)
            ], "Yes! The bundle was too strong to break.", "Tied together, the sticks could not be broken."),
            question("q4-cooperate-lesson", "page-10", "What did the bear brothers learn?", [
                choice("stronger-together", "Working together makes us strong", "person.3.fill", true),
                choice("play-alone", "Play alone all the time", "person.fill", false)
            ], "That’s right! Unity and cooperation make us strong.", "Staying united helps everyone stay strong together.")
        ]
    )

    static let milkmaidAndPail = StoryBook(
        id: "milkmaid-and-pail",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Milkmaid and Her Pail",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "Morning Milk", "Molly the milkmaid filled her bucket with fresh milk at the farm.", "Molly the milkmaid filling a pail with fresh milk."),
            page(2, "Balanced Pail", "She placed the pail carefully on her head and walked to market.", "Molly balancing the milk pail on her head while walking."),
            page(3, "Daydreaming", "As she walked along the sunny path, she began to dream about the future.", "Molly walking along the sunny path daydreaming."),
            page(4, "Buying Eggs", "“I will sell the milk and buy a basket of fresh eggs,” she thought.", "Molly imagining a basket of fresh farm eggs."),
            page(5, "Little Chicks", "“The eggs will hatch into fluffy little chicks in the yard.”", "Molly imagining fluffy yellow chicks hatching."),
            page(6, "Selling Chickens", "“When they grow, I will sell them and buy a pretty new dress.”", "Molly imagining a pretty new dress."),
            page(7, "Tossing Her Head", "She felt so happy that she tossed her head with a smile.", "Molly tossing her head in excitement."),
            page(8, "Spilling the Milk", "Whoops! The pail tipped, and the milk spilled safely onto the grass.", "The milk spilling safely onto the green grass path."),
            page(9, "A Helpful Pause", "Molly sat down calmly and realized she had daydreamed too far.", "Molly sitting down calmly to catch her breath."),
            page(10, "Step by Step", "She learned to focus on one job at a time and finish her work.", "Molly walking back happily, focusing on one step at a time.")
        ],
        questions: [
            question("q1-carry-pail", "page-02", "How did Molly carry her pail of milk?", [
                choice("balanced-head", "Balanced on her head", "person.fill", true),
                choice("red-wagon", "In a red wagon", "cart.fill", false)
            ], "That’s right! Molly balanced the pail on her head.", "She carried the milk pail on top of her head."),
            question("q2-buy-eggs", "page-04", "What did Molly plan to buy first with her milk money?", [
                choice("fresh-eggs", "Fresh eggs", "oval.fill", true),
                choice("bicycle", "A bicycle", "bicycle", false)
            ], "Yes! She planned to buy a basket of fresh eggs.", "She dreamed of buying eggs first."),
            question("q3-milk-spilled", "page-08", "Why did the milk spill onto the grass?", [
                choice("tossed-head", "Molly tossed her head while daydreaming", "arrow.triangle.2.circlepath", true),
                choice("dog-tripped", "A dog tripped her", "pawprint.fill", false)
            ], "Yes! Daydreaming made her toss her head and tip the pail.", "Tossing her head tipped the pail and spilled the milk."),
            question("q4-step-lesson", "page-10", "What did Molly learn at the end?", [
                choice("one-step", "Focus on one job at a time", "checkmark.seal.fill", true),
                choice("count-chicks", "Count chickens before they hatch", "sparkles", false)
            ], "That’s right! Focus on completing the current task step by step.", "Molly learned to complete work one step at a time.")
        ]
    )

    static let oakAndReeds = StoryBook(
        id: "oak-and-reeds",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Oak and the Reeds",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "Beside the River", "A tall, proud oak tree grew near a bed of slender green reeds.", "A tall oak tree standing near green reeds by a riverbank."),
            page(2, "Standing Tall", "The oak boasted, “I am thick and strong; nothing can move me!”", "The oak tree standing stiffly and boasting of its strength."),
            page(3, "Bending Low", "The gentle reeds bowed softly whenever a light breeze blew.", "Slender green reeds bending low in a gentle breeze."),
            page(4, "The Oak's Mocking", "The oak laughed at the reeds for bending down to the wind.", "The oak looking down at the bowing reeds."),
            page(5, "A Strong Wind", "One afternoon, a powerful storm wind blew across the river valley.", "A strong storm wind blowing across the river valley."),
            page(6, "Resisting", "The mighty oak stood stiff and fought against the roaring wind.", "The oak resisting stiffly against the roaring wind."),
            page(7, "Yielding Gracefully", "The slender reeds bent all the way down, yielding to the breeze.", "The reeds bending all the way down gracefully."),
            page(8, "The Oak Rests", "A big gust tipped the stiff oak safely onto the grassy riverbank.", "The oak tree resting safely on the grassy riverbank."),
            page(9, "Standing Strong", "When the storm passed, the flexible reeds stood back up, unharmed.", "The reeds standing back up straight after the storm."),
            page(10, "The Lesson", "The reeds bowed kindly. Flexibility and grace help us survive storms.", "The reeds swaying gently in the sunshine learning flexibility.")
        ],
        questions: [
            question("q1-oak-brag", "page-02", "What did the tall oak tree brag about?", [
                choice("thick-strong", "Being thick and strong", "shield.fill", true),
                choice("red-leaves", "Having red leaves", "leaf.fill", false)
            ], "That’s right! The oak bragged that it was thick and strong.", "The oak boasted that nothing could move it."),
            question("q2-reeds-bend", "page-03", "What did the green reeds do when the wind blew?", [
                choice("bent-gracefully", "Bent low gracefully", "wind", true),
                choice("ran-away", "Ran away", "figure.run", false)
            ], "Yes! The reeds bowed softly whenever the breeze blew.", "The slender reeds bent low with the wind."),
            question("q3-reeds-after", "page-09", "What happened to the reeds after the storm passed?", [
                choice("stood-unharmed", "They stood back up unharmed", "checkmark.circle.fill", true),
                choice("reeds-broke", "They broke in half", "xmark.circle.fill", false)
            ], "Yes! Being flexible allowed the reeds to stand back up unharmed.", "Yielding to the wind kept the reeds safe."),
            question("q4-flexibility-lesson", "page-10", "What lesson does the story teach us?", [
                choice("flexibility-safe", "Flexibility helps us stay safe", "heart.fill", true),
                choice("never-bend", "Never bend for anything", "line.horizontal.3", false)
            ], "That’s right! Bending with grace helps us endure tough times.", "Flexibility and grace help us weather hard storms.")
        ]
    )

    static let boyAndFilberts = StoryBook(
        id: "boy-and-filberts",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Boy and the Filberts",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "A Jar of Nuts", "Leo saw a tall glass jar filled with crunchy filbert nuts on the table.", "Leo looking at a tall glass jar filled with filbert nuts."),
            page(2, "Mother's Permission", "His mother smiled and said, “You may have some nuts for a snack.”", "Leo's mother offering the jar of nuts for a snack."),
            page(3, "Reaching In", "Leo reached his hand into the narrow neck of the glass jar.", "Leo reaching his hand into the narrow neck of the jar."),
            page(4, "A Huge Handful", "He grabbed as many nuts as his fingers could possibly hold.", "Leo grabbing a huge handful of nuts inside the jar."),
            page(5, "Stuck Fast", "When he tried to pull his hand out, his huge fist was stuck tight.", "Leo's big fist stuck in the narrow neck of the jar."),
            page(6, "Pulling Hard", "He pulled and yanked, but his bulging hand could not get through.", "Leo pulling hard trying to get his fist out."),
            page(7, "Wise Advice", "Mother said gently, “Drop half the nuts, and your hand will slip out.”", "Mother advising Leo to drop half the nuts."),
            page(8, "Releasing Some", "Leo opened his fingers and let go of half the nuts inside the jar.", "Leo opening his fingers to release half the nuts."),
            page(9, "Slipping Free", "With a smaller handful, his hand slipped smoothly out of the jar.", "Leo's hand slipping smoothly out of the jar."),
            page(10, "The Lesson", "Leo enjoyed his snack and learned that taking a fair share is best.", "Leo enjoying his nut snack happily with his mother.")
        ],
        questions: [
            question("q1-in-jar", "page-01", "What was inside the tall glass jar?", [
                choice("filbert-nuts", "Crunchy filbert nuts", "circle.grid.cross.fill", true),
                choice("sweet-candy", "Sweet candy", "heart.fill", false)
            ], "That’s right! The jar was filled with crunchy filbert nuts.", "Look in the jar. It was filled with filberts."),
            question("q2-stuck-hand", "page-05", "Why did Leo's hand get stuck in the jar?", [
                choice("too-big-handful", "He grabbed too big a handful", "hand.raised.fill", true),
                choice("jar-shrank", "The jar shrank", "square.split.diagonal", false)
            ], "Yes! Grabbing too many nuts made his fist too big to pull out.", "Holding a huge handful made his hand stuck."),
            question("q3-mother-advice", "page-08", "What did Leo do to get his hand out safely?", [
                choice("dropped-half", "Dropped half the nuts", "hand.point.down.fill", true),
                choice("broke-jar", "Broke the glass jar", "hammer.fill", false)
            ], "Yes! Releasing half the nuts made his hand fit through the neck.", "Dropping half the nuts let his hand slip out easily."),
            question("q4-fair-share-lesson", "page-10", "What did Leo learn at the end?", [
                choice("take-needed", "Take only what you need", "checkmark.seal.fill", true),
                choice("grab-everything", "Grab everything at once", "hand.thumbsdown.fill", false)
            ], "That’s right! Taking a moderate fair share avoids getting stuck.", "Leo learned that taking a fair share is best.")
        ]
    )

    static let twoGoats = StoryBook(
        id: "two-goats",
        schemaVersion: 1,
        contentVersion: "1.0.0",
        title: "The Two Goats",
        locale: "en-US",
        assetVersion: "v1",
        coverAsset: "cover",
        pages: [
            page(1, "Two Mountain Goats", "Gobi and Billy were two brave goats living in the grassy hills.", "Gobi and Billy the mountain goats in grassy hills."),
            page(2, "The Narrow Log", "They met on a narrow wooden log bridge over a shallow stream.", "The two goats walking onto a narrow log bridge over water."),
            page(3, "Meeting in the Middle", "Both goats walked to the middle, facing one another.", "Both goats meeting face to face in the middle of the log."),
            page(4, "No Room to Pass", "The log was too narrow for them to walk past side by side.", "The narrow log with no room for two goats to pass."),
            page(5, "Stubborn Staredown", "At first, neither goat wanted to back up or let the other cross.", "The two goats staring at each other on the bridge."),
            page(6, "Pausing to Think", "They realized pushing would not help either of them reach the other side.", "The goats pausing to think calmly on the bridge."),
            page(7, "A Smart Plan", "Gobi said, “If I lie down flat, you can step gently over me!”", "Gobi talking to Billy offering to lie down."),
            page(8, "Lying Down", "Gobi lay down flat on the wooden log, holding steady.", "Gobi lying flat on the wooden log bridge."),
            page(9, "Stepping Over", "Billy stepped carefully over Gobi's back and reached the bank.", "Billy stepping carefully over Gobi's back to cross."),
            page(10, "Friends at Last", "Gobi stood up and crossed safely too. Cooperation solved their problem.", "Both goats standing safely on opposite banks smiling happily.")
        ],
        questions: [
            question("q1-goats-meet", "page-02", "Where did the two goats meet?", [
                choice("log-bridge", "On a narrow log bridge", "link", true),
                choice("big-boat", "On a big boat", "ferry.fill", false)
            ], "That’s right! They met on a narrow log bridge over a stream.", "Look at the bridge. They met on a wooden log bridge."),
            question("q2-log-narrow", "page-04", "Why couldn't the goats pass each other at first?", [
                choice("too-narrow", "The log was too narrow", "arrow.left.and.right", true),
                choice("too-dark", "It was too dark", "moon.fill", false)
            ], "Yes! The log bridge was too narrow for side-by-side walking.", "The log was narrow so there was no room to squeeze past."),
            question("q3-lie-down", "page-08", "How did the goats cooperate to cross safely?", [
                choice("gobi-lay-flat", "Gobi lay down so Billy could step over", "figure.walk", true),
                choice("pushed-each-other", "They pushed each other", "arrow.2.squarepath", false)
            ], "Yes! Gobi lay down flat so Billy could step over his back.", "Cooperating let both goats pass one at a time."),
            question("q4-cooperate-conflict", "page-10", "What does this story teach us?", [
                choice("cooperation-solves", "Cooperation and compromise solve problems", "heart.fill", true),
                choice("never-compromise", "Never compromise with others", "xmark.seal.fill", false)
            ], "That’s right! Working together and compromising solves conflicts peacefully.", "Cooperation helped both goats cross safely!")
        ]
    )

    static let allBooks: [StoryBook] = [
        cowboyWhoCriedTiger,
        tortoiseAndHare,
        lionAndMouse,
        foxAndGrapes,
        antAndDove,
        antAndGrasshopper,
        crowAndPitcher,
        townMouseAndCountryMouse,
        dogAndHisReflection,
        foxAndCrow,
        gooseAndGoldenEggs,
        northWindAndSun,
        bundleOfSticks,
        milkmaidAndPail,
        oakAndReeds,
        boyAndFilberts,
        twoGoats
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
