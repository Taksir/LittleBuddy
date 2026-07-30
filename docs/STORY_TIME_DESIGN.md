# Story Time — Product and Content Design

## 1. Feature definition

Story Time is the app's second child activity. It presents a short illustrated book
with synchronized text and narration, followed by a gentle picture-based
comprehension review.

Initial content:

- Story id: cowboy-who-cried-tiger
- Display title: The Cowboy Who Cried Tiger
- Audience: ages 3–5 with a nearby caregiver recommended
- Language: English
- Format: cover plus ten narrated story pages
- Review: four questions, one at a time
- Input: touch only
- Runtime: fully offline

This activity must be isolated from Hidden Objects behind the common app shell. It
must not reuse hidden-object gameplay state, target selection, or miss counting.

## 2. Content-safety decision

The requested ending remains faithful: the tiger catches and eats the cowboy.
Because the audience is preschool age, the event is narrated plainly but shown only
off-screen.

Required constraints for page 8:

- No attack is visible.
- No blood, injury, teeth close-up, torn clothing, bones, or frightened face.
- Show the quiet field, the cowboy's hat, bent grass, and tiger tracks.
- The tiger may be seen only at a distance, walking away into the grass.
- Music and narration remain solemn, not sensational.

The lesson must not imply that a child who previously lied is undeserving of help.
The closing narration therefore includes both ideas:

- telling the truth protects trust;
- if someone is genuinely unsafe, they should keep seeking a trusted grown-up.

## 3. Home-screen placement

The child home screen becomes a two-card activity shelf:

1. Find Hidden Objects
2. Story Time

The cards use the same size, visual weight, and interaction style. Story Time uses a
large open-book illustration and speaks “Story Time” when focused or tapped. Neither
card is marked as more important.

The app shell owns:

- home navigation;
- parental gate;
- shared voice/audio service;
- shared accessibility settings;
- activity registration;
- progress summaries.

Story Time owns:

- story library and cover;
- page reader;
- narration state;
- review questions;
- story-session events.

## 4. Child flow

1. Child taps **Story Time**.
2. A single large book cover appears for **The Cowboy Who Cried Tiger**.
3. Tapping **Read** opens page 1 and begins narration.
4. The child moves forward or backward using either a horizontal swipe or large
   arrow buttons.
5. Entering a page stops stale audio and narrates the visible page.
6. The speaker button replays the current page.
7. Page 10 offers **Think About the Story** and **Read Again**.
8. The review shows selected story pages again and asks four narrated questions.
9. The child answers by tapping one of two large illustrated choices.
10. The guide gives a specific correction or confirmation.
11. The review ends with calm praise and choices for **Read Again** or **Home**.

No reading ability is required. On-screen text supports co-reading with an adult.

## 5. Reader layout

Landscape iPad layout:

- Top 72 points: Home, story title, page dots, replay narration.
- Middle: full-width story illustration using approximately 70% of available height.
- Bottom: one short text card with at most three lines at the minimum iPad size.
- Lower corners: large previous and next buttons, at least 72×72 points.
- Entire art area accepts horizontal swipes.

Page navigation rules:

- Swipe left or tap the right arrow to move forward.
- Swipe right or tap the left arrow to move backward.
- The left arrow is disabled on page 1.
- The right arrow becomes **Finish Story** on page 10.
- A page transition immediately stops the previous narration.
- Narration begins after the transition settles, approximately 250 milliseconds.
- Rapid swipes debounce narration so clips never overlap.
- Returning to a page narrates it again.
- Reduce Motion replaces the horizontal slide with a short crossfade.
- The app remembers the current page only while the reading session is active.
- Leaving through Home saves progress and offers **Continue** on the cover.

Do not use an ornamental page-curl effect in the first implementation. A responsive
horizontal slide is clearer, easier to test, and works in both directions.

## 6. Visual direction and continuity

The book should match the premium storybook quality of the Hidden Objects scenes:

- polished 2D picture-book illustration;
- realistic environments, materials, anatomy, lighting, and depth;
- warm cartoon character design;
- clean contours and expressive but not exaggerated faces;
- landscape 3:2 source images at 1536×1024 or larger;
- no embedded words, logos, labels, borders, or watermarks;
- text is rendered by SwiftUI, never baked into artwork.

Character bible:

- Cole: a young adult cowboy, warm tan skin, short dark-brown hair, green neckerchief,
  cream shirt, brown vest, blue trousers, brown boots, and a light-brown hat.
- Mara: an adult rancher with a red shirt, denim overalls, and a dark braid.
- Ben: an older rancher with a blue shirt, gray hair, and a gentle expression.
- Tiger: realistic orange-and-black markings with rounded picture-book styling;
  calm stalking posture, never monstrous or anthropomorphic.
- Setting: a small cattle ranch bordering tall golden grass and distant green hills.

Every prompt must repeat the character bible. Before producing all pages, create and
approve a character reference sheet. Page images must maintain clothing, proportions,
colors, and setting geography.

## 7. Ten-page manuscript and art plan

The on-screen text and narration transcript are identical unless a narration note
explicitly adds a short pause. The narrator uses a gentle storytelling voice and
slightly changes expression for quoted dialogue without becoming theatrical.

### Page 1 — The ranch

Text:

> Cole was a cowboy. Each day, he watched the calves near the tall grass while the
> other ranchers worked nearby.

Art:

Wide establishing view. Cole sits safely on a fence at the left, calves graze in the
middle, Mara and Ben repair a gate in the distance, and tall golden grass borders the
right side.

Learning purpose: establish character, job, and nearby helpers.

### Page 2 — The first lie

Text:

> One quiet afternoon, Cole felt bored. He shouted, “Tiger! Tiger! Please help!” But
> there was no tiger.

Art:

Cole cups his hands and calls toward the ranch. The tall grass is visibly empty. His
expression is playful rather than afraid.

Learning purpose: distinguish a spoken claim from what is actually present.

### Page 3 — The joke

Text:

> Mara and Ben hurried to Cole. Cole laughed. “I fooled you!” The ranchers felt
> worried, not amused.

Art:

Mara and Ben arrive out of breath carrying harmless ranch tools. Cole laughs. Their
faces show calm concern, not anger or scolding.

Learning purpose: recognize how a lie affects other people.

### Page 4 — The second lie

Text:

> The next day, Cole called “Tiger!” again. Again, the ranchers ran to help. Again,
> there was no tiger.

Art:

Use a new composition near a water trough. Cole calls from the foreground while the
ranchers approach. Empty grass is clearly visible.

Learning purpose: show repetition and consequence building.

### Page 5 — The warning

Text:

> “Only call when danger is real,” Mara said. “If you keep lying, we may not believe
> you.”

Art:

Mara kneels to Cole's eye level while Ben stands nearby. Cole listens. Body language
is caring and serious, never threatening.

Learning purpose: introduce trust in concrete language.

### Page 6 — A real tiger

Text:

> Soon, the tall grass rustled. A real tiger crept toward Cole. This time, he was
> telling the truth.

Art:

Cole stands beside the fence and sees the tiger emerging from distant grass. Keep
ample distance between them. Cole looks surprised; the tiger is alert but not lunging.

Learning purpose: recall the difference between earlier lies and current reality.

### Page 7 — No one comes

Text:

> “Tiger! Please help!” Cole cried. The ranchers heard him, but they thought it was
> another trick.

Art:

Split-depth composition rather than a comic panel: Cole calls from a far hill while
Mara and Ben pause by the barn in the foreground, exchanging doubtful looks. The
tiger remains distant.

Learning purpose: connect broken trust to delayed help.

### Page 8 — The consequence

Text:

> No one came in time. The tiger caught Cole and gobbled him up.

Art:

After the event, show an empty field at sunset. Cole's hat rests near the fence,
golden grass is bent, and tiger tracks lead away. A small tiger silhouette may be far
in the distance. Do not depict contact, injury, remains, or fear.

Learning purpose: deliver the requested consequence without graphic imagery.

### Page 9 — The ranchers understand

Text:

> Later, Mara and Ben found Cole's hat and the tiger tracks. They were sad that they
> had not known his warning was true.

Art:

Mara holds the hat while Ben studies the tracks. Their expressions are gentle and
sad. Use soft evening light and no tiger.

Learning purpose: identify sadness and the cost of lost trust without blame language.

### Page 10 — The lesson

Text:

> Telling the truth helps people trust us. If you are ever in danger, keep calling
> for a trusted grown-up.

Art:

Symbolic, comforting closing image: the ranch at sunrise, secure fence, calves near
Mara and Ben, and Cole's hat hanging respectfully by the barn. Do not show Cole as a
ghost or imply resurrection.

Learning purpose: state the moral and preserve an appropriate real-world safety rule.

## 8. Narration

Voice direction:

- adult feminine presentation;
- caring, steady, and clear;
- approximately 0.9× ordinary conversational pace;
- short pauses at sentence boundaries;
- gentle vocal distinction for dialogue;
- no growling tiger effect;
- no scream or eating sound;
- no suspense music under pages 6–9;
- solemn but emotionally regulated delivery on pages 8 and 9;
- reassuring delivery on page 10.

Production policy:

1. Every page has an approved transcript.
2. Preferred delivery is a reviewed bundled audio clip.
3. AVSpeechSynthesizer may read the exact transcript as an offline fallback.
4. Any Gemini use happens only during developer-side authoring.
5. No API key or generative model is present in the child app.
6. Page navigation cancels current narration before another clip begins.

Optional quiet ambience may be bundled separately, defaulting to off. Narration
always takes priority.

## 9. Comprehension review

The review presents four questions in story order. Each question reuses the exact
referenced page illustration above the answer choices. It does not crop or alter the
historical scene in a way that changes its meaning.

Each answer card contains:

- a simple picture cue;
- one to four words of adult-readable text;
- a minimum 120-point height;
- a spoken label when tapped or focused;
- shape and icon feedback in addition to color.

### Question 1

Referenced page: 2

Prompt:

> Was there really a tiger the first time Cole called for help?

Choices:

- No tiger — correct
- A real tiger — incorrect

Correct response:

> That's right. The grass was empty. There was no tiger.

Correction:

> Not this time. Look at the empty grass. Cole called “Tiger,” but no tiger was there.

### Question 2

Referenced page: 3

Prompt:

> How did Mara and Ben feel when Cole laughed?

Choices:

- Worried — correct
- Amused — incorrect

Correct response:

> Yes. They felt worried because they had hurried to help.

Correction:

> Look at their faces. They were worried, not amused.

### Question 3

Referenced page: 6

Prompt:

> What came out of the tall grass later?

Choices:

- A tiger — correct
- A calf — incorrect

Correct response:

> Yes. A real tiger came out of the grass.

Correction:

> Look beside the tall grass. The striped animal is the tiger.

### Question 4

Referenced page: 10, with small thumbnails from pages 2 and 6 as answer cues

Prompt:

> What does Cole's story teach us to do?

Choices:

- Tell the truth — correct
- Call for danger as a joke — incorrect

Correct response:

> That's right. Telling the truth helps people trust us.

Correction:

> Calling danger as a joke made it hard to know when Cole needed help. The lesson is
> to tell the truth.

## 10. Answer and correction behavior

Only the answer cards accept a response. Swiping and the page arrows are disabled
while a question is active.

Correct first choice:

1. Add a gold outline and checkmark.
2. Speak the specific correct response.
3. Record firstTryCorrect.
4. Advance after the narration ends or the child taps Continue.

Incorrect first choice:

1. Use a soft neutral outline and small side-to-side movement; never show a red X.
2. Speak the specific correction.
3. Keep both cards visible.
4. Gently pulse the correct card after the correction.
5. Require the child to tap the correct card to complete the question.
6. Record correctedAfterHelp rather than incorrect or failed.

If the child taps the wrong card a second time, the guide selects and explains the
correct card, then enables Continue. The child is never trapped and never loses a
life, point, or reward.

The speaker button repeats the question and both answer labels. It does not count as
an attempt.

## 11. State model

Suggested reader states:

    library
    cover
    loadingStory
    reading(pageIndex)
    transitioning(fromPage, toPage)
    storyComplete
    reviewIntro
    asking(questionIndex)
    awaitingChoice(questionIndex)
    correcting(questionIndex, selectedChoice)
    confirming(questionIndex)
    reviewComplete
    paused
    failedSafe

State rules:

- Only reading accepts page-turn intents.
- Only awaitingChoice accepts answer intents.
- Audio completion is associated with a state token so stale callbacks do nothing.
- One page or question transition occurs at a time.
- Backgrounding pauses narration and active-time measurement.
- Restoring the app returns to the visible page without fabricating completion.
- Missing image or audio skips safely to a calm error screen behind the child shell.

## 12. Content model

Conceptual manifest:

    StoryBook
      id
      schemaVersion
      contentVersion
      title
      locale
      coverImage
      pages[]
      questions[]
      contentRating

    StoryPage
      id
      order
      imageAsset
      displayedText
      narrationAsset
      narrationTranscript
      altText

    StoryQuestion
      id
      referencedPageIDs[]
      prompt
      promptAudio
      choices[]
      correctChoiceID
      correctResponse
      correctionResponse

    StoryChoice
      id
      label
      imageAsset
      accessibilityLabel

Assets belong under a versioned namespace such as:

    Resources/Stories/cowboy-who-cried-tiger/v1/
      manifest.json
      cover.png
      pages/page-01.png ... page-10.png
      choices/
      audio/

## 13. Progress and parent reporting

Story Time emits append-only local events:

- storyStarted
- pageViewed
- narrationCompleted
- narrationReplayed
- pageRevisited
- storyCompleted
- reviewStarted
- questionPresented
- choiceSelected
- correctionGiven
- questionCompleted
- reviewCompleted
- storyExited

Do not record raw touch coordinates, free-form child text, microphone audio, or
identifiers.

Parent dashboard additions:

- stories started;
- stories completed;
- total reading time;
- narration replays;
- review questions completed;
- first-choice correct count;
- corrected-after-help count.

Use language such as “answered independently” and “answered after help.” Do not call
the result an IQ, comprehension age, grade, diagnosis, or pass/fail score.

## 14. Accessibility

- Narration is not a substitute for VoiceOver labels on controls.
- Page art has concise descriptive alt text.
- On-screen text supports Dynamic Type without covering essential faces or action.
- Text maintains WCAG AA contrast against an opaque or strongly blurred card.
- Answer cards use icon, shape, and speech in addition to color.
- All child controls are at least 60×60 points, preferably 72×72.
- Reduce Motion uses crossfades and disables pulse or shake.
- Guided Access must not block required controls.
- System volume and interruption behavior are respected.

## 15. Acceptance criteria

- Story Time appears as a separate home activity without breaking Hidden Objects.
- The cover and all ten pages work without a network connection.
- Every page displays its image and exact reviewed text.
- Narration never overlaps across page changes.
- The child can move forward and backward by swipe and by buttons.
- Page 1 cannot navigate backward; page 10 finishes predictably.
- Leaving and returning offers to continue the active story.
- Completing the story launches the four-question review.
- Every question shows the referenced story page again.
- Every question has exactly two large visual choices.
- Correct and incorrect choices receive specific spoken feedback.
- A wrong response teaches the answer without shame and cannot trap the child.
- Story and review progress appears in the parent area as observational data.
- No microphone, API key, advertising, analytics, or runtime generative AI is added.
- The tiger consequence is never graphically illustrated or sonically dramatized.

## 16. Decisions already made for implementation

- One story at launch; architecture supports more later.
- Cover plus ten story pages.
- Four fixed review questions in story order for the first release.
- Touch answers, not spoken-answer recognition.
- Literal but off-screen tiger ending.
- Reviewed text and audio assets with local TTS fallback.
- No auto-advance between story pages.
- Child-controlled forward and backward navigation.
- Fully local progress and offline playback.

There are no blocking product questions for the first implementation. The parent may
later choose whether to add an alternate gentler ending, but that is outside this
initial story's scope.
