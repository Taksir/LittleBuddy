# Future Codex Verification Handoff — Scope Locked

## Read this first

Verify only the three new stories and the shared Story Time code Luna changed to support them.

Do **not** re-audit the entire project. Do **not** revisit old Hidden Objects scenes, bounding boxes, image-generation history, the native Xcode target, or the existing Cowboy story content unless Luna changed those files or a shared regression directly fails.

Authoritative inputs:

- `docs/THREE_NEW_STORIES_DESIGN.md`
- `docs/THREE_NEW_STORIES_LUNA_XHIGH_BRIEF.md`
- Luna’s changed-file summary and diff
- The 33 PNGs under the three new story resource directories

## Verification order

### 1. Establish the exact diff

- Read Luna’s completion report.
- Inspect Git status and the diff limited to files Luna touched.
- Separate the already-supplied story assets/design docs from Luna’s implementation changes.
- If unrelated files changed, flag them; do not turn that into a whole-repository review.

### 2. Validate only the three asset sets

For each of `tortoise-and-hare`, `lion-and-mouse`, and `fox-and-grapes`:

- directory is `AskAndFind.swiftpm/Sources/AppModule/Resources/Stories/<story-id>/v1`;
- exactly 11 PNGs exist: `cover.png`, then `page-01.png` through `page-10.png`;
- each image decodes successfully and is 1536 × 1024 (3:2);
- files are not byte-identical to one another;
- none is a known placeholder, flat color panel, emoji/SF Symbol, or text-only mock;
- visually spot-check the cover and all ten pages for the intended characters, sequence, absence of embedded text/watermarks, and age-appropriate tone.

Do not re-verify unrelated Hidden Objects or Cowboy assets.

### 3. Validate the three catalog entries

For each new story, compare the implementation against `THREE_NEW_STORIES_DESIGN.md`:

- exact ID, display title, locale, content version, and asset version;
- exactly 10 pages in order;
- exact page titles and narration, allowing only source-code quote escaping;
- exactly four questions;
- exactly two choices and one correct answer per question;
- valid reference page and exact correct/correction feedback;
- all referenced asset names resolve in `Bundle.module`.

Also confirm all catalog story IDs are unique. Do not editorially rewrite the approved content during verification.

### 4. Review Luna’s shared Story Time changes

Focus on these failure risks:

- selected story ID is carried through library routing into `StoryTimeView` and `StoryTimeCoordinator`;
- resource paths derive from the selected story instead of the Cowboy directory;
- no fixed `book.pages[9]` access remains;
- switching books resets session/review/narration state;
- page changes and dismissals cancel stale speech;
- parent history resolves the correct title from the stored story ID;
- existing UserDefaults history remains backward compatible;
- the production path does not require story-specific fallback-art cases.

### 5. Build and focused behavior check

Use an Apple toolchain for the definitive build because this is an iPadOS application package. Record the exact build/test command and result. If verification occurs on Windows, perform static/data/asset checks and clearly leave Apple compilation and iPad runtime behavior as unverified—not passed.

On iPad or an iPad simulator, check only:

1. Story Time opens the library.
2. Open each of the three new covers.
3. For each new story, go forward, back, replay narration, and reach page 10.
4. Complete all four questions once, including at least one wrong choice and correction.
5. Confirm the correct reference-page art is shown during review.
6. Confirm completion appears under the correct parent-history title.
7. Switch between two stories while narration is playing and confirm old speech stops.

Minimal shared regression check only:

- open the Cowboy story and turn one page;
- launch Hidden Objects once.

Stop there unless one of those shared checks fails.

## Required final report

Return a verdict limited to the three new stories:

- **Pass** — content, assets, build, and focused runtime behavior all passed;
- **Conditional pass** — static/asset checks passed but Apple build or iPad runtime was unavailable;
- **Fail** — list concrete issues with file and line references plus the smallest corrective action.

Include:

- checks performed and evidence;
- issues ordered by severity;
- platform/testing boundary;
- explicit sentence: “No whole-project re-audit was performed; verification was intentionally limited to the three new stories and their shared Story Time integration.”

## Copy/paste prompt for the next model

> Verify Luna’s implementation using `docs/THREE_NEW_STORIES_VERIFICATION_HANDOFF.md`. Stay scope-locked: test only The Tortoise and the Hare, The Lion and the Mouse, The Fox and the Grapes, plus the shared Story Time integration Luna changed. Do not re-audit the whole project. Compare against `docs/THREE_NEW_STORIES_DESIGN.md`, validate the 33 supplied PNG assets, run the strongest available build/tests, and report a focused verdict with file/line evidence.
