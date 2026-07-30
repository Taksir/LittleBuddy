# Three New Story Time Books — Content and Experience Design

Status: approved implementation specification  
Audience: Luna xHigh and the later verification pass  
Scope: only `tortoise-and-hare`, `lion-and-mouse`, and `fox-and-grapes`

## Product rules shared by all three books

- Audience: ages 3–5; English (`en-US`) only.
- Each book has one cover, 10 narrated pages, then a four-question review.
- The child can move backward or forward through pages at any time.
- Opening a page reads its narration in the existing caring female system voice.
- Replaying narration, leaving a page, closing the book, or entering review must cancel the previous utterance cleanly.
- Review questions reuse the referenced story-page image and are read aloud.
- Each question has exactly two large answer choices and exactly one correct answer.
- A correct answer receives specific, gentle confirmation. A wrong answer receives a specific correction and may be tried again; never shame, score, or rush the child.
- Keep completion/progress logging compatible with the existing parent dashboard.
- No microphone, cloud API, Gemini request, login, advertising, or network dependency is needed.

## Asset contract

All supplied art is final 3:2 PNG artwork with no text embedded in the image. Luna must use these exact resource names and must not replace them with generated shapes, emoji, SF Symbols, gradients, or other placeholders.

```text
AskAndFind.swiftpm/Sources/AppModule/Resources/Stories/
  tortoise-and-hare/v1/cover.png, page-01.png ... page-10.png
  lion-and-mouse/v1/cover.png, page-01.png ... page-10.png
  fox-and-grapes/v1/cover.png, page-01.png ... page-10.png
```

Each story uses `contentVersion = "1.0.0"` and `assetVersion = "v1"`.

## Book 1 — The Tortoise and the Hare

Metadata:

- Story ID: `tortoise-and-hare`
- Display title: `The Tortoise and the Hare`
- Characters: Tessa the tortoise and Hugo the hare
- Core idea: steady effort and finishing what we start

Character/art continuity:

- Tessa: small female tortoise; olive-green skin; amber-brown patterned shell; hazel eyes; sky-blue neckerchief.
- Hugo: tall slim male hare; silver-gray fur; cream muzzle and belly; long pink-inner ears; warm brown eyes; rust-red sleeveless running vest.
- Setting: sunlit woodland meadow, winding dirt race path, wildflowers, broad oak tree, finish ribbon.

### Pages

1. `page-01.png` — **The Meadow**  
   “In a sunny meadow, Hugo the hare loved to run fast. Tessa the tortoise moved slowly, one steady step at a time.”
2. `page-02.png` — **The Challenge**  
   “Hugo told everyone he was the fastest. Tessa smiled and said, ‘Let’s have a race.’”
3. `page-03.png` — **Ready, Set, Go**  
   “The forest friends marked a path. At the signal, Hugo dashed ahead while Tessa began calmly.”
4. `page-04.png` — **Far Ahead**  
   “Soon Hugo was far in front. He looked back and could barely see Tessa on the path.”
5. `page-05.png` — **Step by Step**  
   “Tessa kept moving. Over the bridge and up the hill, she did not stop.”
6. `page-06.png` — **A Quick Rest**  
   “Hugo felt sure he would win. He rested beneath an oak tree and soon fell asleep.”
7. `page-07.png` — **Passing By**  
   “Tessa reached the oak. She walked quietly past sleeping Hugo and continued toward the finish.”
8. `page-08.png` — **Wide Awake**  
   “At last Hugo woke up. He saw Tessa near the finish and ran as fast as he could.”
9. `page-09.png` — **The Finish**  
   “Tessa crossed the finish first. The forest friends cheered for her steady effort.”
10. `page-10.png` — **The Lesson**  
    “Hugo congratulated Tessa. He learned that speed is useful, but steady effort and finishing what we start matter too.”

### Review

1. Reference `page-02.png`; ask: “Who invited Hugo to race?”  
   Choices: `Tessa` (correct), `Robin`  
   Correct reply: “Yes. Tessa calmly invited Hugo to race.”  
   Correction: “Look beside Hugo. Tessa the tortoise invited him to race.”
2. Reference `page-06.png`; ask: “What did Hugo do beneath the oak tree?”  
   Choices: `Fell asleep` (correct), `Kept running`  
   Correct reply: “That’s right. Hugo stopped to rest and fell asleep.”  
   Correction: “Look under the oak. Hugo is sleeping.”
3. Reference `page-09.png`; ask: “Who crossed the finish first?”  
   Choices: `Tessa` (correct), `Hugo`  
   Correct reply: “Yes. Tessa crossed the finish first.”  
   Correction: “Look at the ribbon. Tessa reached it first.”
4. Reference `page-10.png`; ask: “What helped Tessa finish the race?”  
   Choices: `Steady effort` (correct), `Giving up`  
   Correct reply: “That’s right. Tessa kept going one steady step at a time.”  
   Correction: “Tessa did not give up. Her steady effort helped her finish.”

## Book 2 — The Lion and the Mouse

Metadata:

- Story ID: `lion-and-mouse`
- Display title: `The Lion and the Mouse`
- Characters: Leo the lion and Mina the mouse
- Core idea: kindness matters, and help can come in every size

Character/art continuity:

- Leo: large adult male lion; golden-tan fur; rounded chestnut-and-copper mane; amber eyes; broad paws; calm noble face.
- Mina: tiny female field mouse; warm gray-brown fur; cream belly; round peach-centered ears; bright dark eyes; long tail; teal neckerchief.
- Setting: warm African savanna, acacia tree, golden grasses, rocks, distant blue hills.

### Pages

1. `page-01.png` — **A Quiet Morning**  
   “Leo the lion slept beneath an acacia tree. Nearby, Mina the mouse gathered seeds in the grass.”
2. `page-02.png` — **A Surprise**  
   “Mina hurried across Leo’s paw. Leo woke with a start and stopped her beside his great paw.”
3. `page-03.png` — **A Promise**  
   “‘Please let me go,’ Mina said. ‘Someday I may help you.’ Leo wondered how such a small mouse could help.”
4. `page-04.png` — **Kindness**  
   “Leo chose to be kind and let Mina go. Mina thanked him and hurried home.”
5. `page-05.png` — **The Rope Net**  
   “Later, a heavy rope net fell around Leo. He pulled, but the ropes only tightened.”
6. `page-06.png` — **Mina Hears**  
   “Leo called across the savanna. Mina recognized his voice and hurried to help.”
7. `page-07.png` — **Small Teeth, Big Help**  
   “Mina worked at one knot, then another. Her tiny teeth loosened the strong ropes.”
8. `page-08.png` — **Free Again**  
   “At last the net opened. Leo stepped out, safe and free.”
9. `page-09.png` — **Thank You**  
   “Leo thanked Mina. Now he understood that being small did not mean being unable to help.”
10. `page-10.png` — **The Lesson**  
    “Leo and Mina became true friends. Kindness matters, and help can come in every size.”

### Review

1. Reference `page-02.png`; ask: “Who woke Leo?”  
   Choices: `Mina` (correct), `A bird`  
   Correct reply: “Yes. Mina the mouse woke Leo.”  
   Correction: “Look beside Leo’s paw. Mina the mouse woke him.”
2. Reference `page-04.png`; ask: “What did Leo choose to do?”  
   Choices: `Let Mina go` (correct), `Keep her there`  
   Correct reply: “That’s right. Leo chose kindness and let Mina go.”  
   Correction: “Look at Mina leaving safely. Leo let her go.”
3. Reference `page-07.png`; ask: “How did Mina help Leo?”  
   Choices: `Loosened the ropes` (correct), `Ran away`  
   Correct reply: “Yes. Mina loosened the rope knots.”  
   Correction: “Look at the knot. Mina is loosening the ropes.”
4. Reference `page-10.png`; ask: “What does the story teach us?”  
   Choices: `Anyone can help` (correct), `Only big animals help`  
   Correct reply: “That’s right. Help can come in every size.”  
   Correction: “Mina was tiny and still helped Leo. Anyone can help.”

## Book 3 — The Fox and the Grapes

Metadata:

- Story ID: `fox-and-grapes`
- Display title: `The Fox and the Grapes`
- Character: Felix the fox
- Core idea: it is okay to feel disappointed; name the feeling honestly and choose a constructive next step

Character/art continuity:

- Felix: young adult male red fox; rich russet-orange fur; cream muzzle, chest, and tail tip; dark brown lower legs; large amber eyes; expressive pointed ears; forest-green neckerchief.
- Setting: sunny old-world vineyard garden, wooden grape arbor, low stone wall, earth path, green vines, ripe purple grapes.

### Pages

1. `page-01.png` — **The Vineyard**  
   “Felix the fox walked through a sunny vineyard. Above him hung a beautiful bunch of purple grapes.”
2. `page-02.png` — **A Tasty Wish**  
   “The grapes looked cool and juicy. Felix stretched up, but they were much too high.”
3. `page-03.png` — **The First Jump**  
   “Felix jumped with all his might. He landed safely, but the grapes stayed out of reach.”
4. `page-04.png` — **Another Idea**  
   “He climbed onto a low stump and reached again. His paws still could not touch the grapes.”
5. `page-05.png` — **One More Try**  
   “Felix took a running start and leaped. He came close, but not close enough.”
6. `page-06.png` — **Disappointed**  
   “Felix sat in the shade to catch his breath. He felt tired and disappointed.”
7. `page-07.png` — **Pretending**  
   “‘Those grapes are probably sour anyway,’ Felix said, even though he had wanted them very much.”
8. `page-08.png` — **Walking Away**  
   “Felix walked away with his nose in the air. Pretending made his disappointment no smaller.”
9. `page-09.png` — **An Honest Feeling**  
   “Felix paused. ‘I am disappointed because I could not reach them,’ he admitted.”
10. `page-10.png` — **The Lesson**  
    “It is okay to feel disappointed. We can tell the truth about our feelings, try again later, or ask for help.”

### Review

1. Reference `page-02.png`; ask: “What did Felix want?”  
   Choices: `Purple grapes` (correct), `A red apple`  
   Correct reply: “Yes. Felix wanted the purple grapes.”  
   Correction: “Look above Felix. He wanted the purple grapes.”
2. Reference `page-05.png`; ask: “Could Felix reach the grapes?”  
   Choices: `No` (correct), `Yes`  
   Correct reply: “That’s right. Felix tried, but he could not reach them.”  
   Correction: “Look at the space above his paws. The grapes were still too high.”
3. Reference `page-07.png`; ask: “What did Felix say about the grapes?”  
   Choices: `They were probably sour` (correct), `They were easy to reach`  
   Correct reply: “Yes. Felix said they were probably sour.”  
   Correction: “Felix could not reach them, so he pretended they were probably sour.”
4. Reference `page-10.png`; ask: “What can we do when we feel disappointed?”  
   Choices: `Tell the truth and choose a next step` (correct), `Pretend we never wanted it`  
   Correct reply: “That’s right. We can name the feeling and choose what to do next.”  
   Correction: “It is okay to say, ‘I feel disappointed,’ and then try later or ask for help.”

## Art-generation record

The images were created with the built-in ImageGen workflow, one raster asset per scene. The reusable prompt pattern was:

> Landscape 3:2 children’s storybook illustration, premium polished 2D cartoon with believable animal anatomy, clean expressive contours, soft cel shading, warm natural sunlight, rich but gentle color, detailed natural textures, cinematic composition suitable for ages 3–5. Keep the locked character markings, clothing, proportions, and setting consistent. No words, letters, captions, signs, logos, watermark, border, split panels, photorealism, 3D render, or scary imagery. [Then add the character bible, location bible, and the single page beat defined above.]

The scene descriptions and character continuity in this document are the authoritative prompt set for future regeneration. Do not regenerate an asset merely because the art style differs slightly from the existing cowboy book.
