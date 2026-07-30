# Luna xHigh Implementation Brief — Three New Story Time Books

## Mission

Implement only these three books from `docs/THREE_NEW_STORIES_DESIGN.md`:

1. `tortoise-and-hare`
2. `lion-and-mouse`
3. `fox-and-grapes`

All 33 final PNG assets already exist. Do not generate, redraw, rename, crop, or substitute them. Do not rewrite the approved narration or review wording.

The shipping target is the direct iPad Swift package at `AskAndFind.swiftpm`. Do not implement this work in the older `SpeechTherapy` Xcode/XcodeGen target.

## Scope guardrails

- Preserve the current Cowboy story and Hidden Objects behavior.
- Do not redesign unrelated screens.
- Do not add a backend, Google/Gemini API call, microphone access, authentication, analytics service, or network dependency.
- Use the current on-device speech mechanism and the existing local parent progress store.
- Refactor shared Story Time code only as much as needed to support a reusable multi-book catalog.
- Maintain iPadOS 17, landscape orientation, and touch targets appropriate for ages 3–5.

## Required user experience

### Story library

The Story Time home card must open a child-friendly library instead of immediately opening the Cowboy book. Show four selectable covers:

- The Cowboy Who Cried Tiger (existing)
- The Tortoise and the Hare
- The Lion and the Mouse
- The Fox and the Grapes

Each card needs the cover artwork and title. Opening a card starts that selected book at its cover. Returning from a book goes back to the library without corrupting progress.

### Reading and review

For every new book:

- Display the supplied cover.
- Present exactly 10 pages in the specified order.
- Keep both backward and forward navigation.
- Read the current page aloud with the existing caring female voice.
- Cancel stale narration on page changes, replay, dismissal, phase changes, and book switches.
- Start the four-question review only after the last page.
- Reuse the question’s referenced page image.
- Show exactly two large choices.
- Speak the exact specific correct/correction response from the design.
- Log completion and review accuracy with the correct story ID/title.

## Data and architecture changes

The implementation must be data-driven. Do not create three copies of the reader UI or add 30 story-specific rendering cases.

### Catalog

- Extend `StoryCatalog` to expose an ordered collection such as `allBooks` containing all four stories.
- Add the three books using the exact metadata, page text, questions, and feedback in the design specification.
- Keep story IDs unique and stable.
- Use `contentVersion = "1.0.0"`, locale `en-US`, and `assetVersion = "v1"` for each new book. If the model lacks `assetVersion`, add a generic equivalent.
- Provide safe lookup by story ID for navigation and parent-history display.

### Resource resolution

Replace the hard-coded `Stories/cowboy-who-cried-tiger/v1` resource directory in `StoryTimeViews.swift` with a path derived from the selected book’s stable ID and asset version.

The resolver contract is:

```text
Stories/<storyID>/<assetVersion>/<assetName>.png
```

`cover.png` and every referenced `page-NN.png` must resolve through `Bundle.module`. A fallback may remain for defensive behavior, but missing supplied art is an implementation failure; it must not silently appear as an acceptable placeholder.

### Routing and state

- Route with the selected story ID plus a fresh session token; do not keep the selected story in a global singleton.
- `StoryTimeView` and `StoryTimeCoordinator` must receive the selected `StoryBook` rather than constructing `StoryCatalog.cowboyWhoCriedTiger` internally.
- A new book/session must reset page index, review index, answer state, and narration state.
- Avoid using a stale view identity when switching between two books.

### Generic page handling

- Remove fixed indexing such as `book.pages[9]` in completion/review surfaces.
- Use a guarded `book.pages.last` or the question’s referenced page as appropriate.
- Guard empty or malformed content without crashing, while catalog validation ensures shipped books are valid.
- `StoryArtKind` is currently Cowboy-specific. Do not expand it with 30 new cases. Remove it from production asset selection or make fallback behavior generic; filenames from the book data are authoritative.

### Parent progress

- Preserve backward compatibility with the existing UserDefaults key `askAndFind.playground.storySessions.v1`.
- Store the correct new story ID and content version in every new session.
- Resolve displayed history titles from the catalog. Remove any hard-coded Cowboy title from the parent dashboard.
- Do not erase or migrate away existing Cowboy history unless a backward-compatible migration is truly required.

## Files expected to change

Work primarily within:

- `AskAndFind.swiftpm/Sources/AppModule/AskAndFindApp.swift`
- `AskAndFind.swiftpm/Sources/AppModule/StoryModels.swift`
- `AskAndFind.swiftpm/Sources/AppModule/StoryCatalog.swift`
- `AskAndFind.swiftpm/Sources/AppModule/StoryTimeCoordinator.swift`
- `AskAndFind.swiftpm/Sources/AppModule/StoryTimeViews.swift`
- `AskAndFind.swiftpm/Sources/AppModule/StoryProgressStore.swift`

You may add a small Story Library view or focused tests/validation helpers under the direct package. Avoid touching the native target and unrelated Hidden Objects files.

## Acceptance criteria

### Catalog/content

- Catalog contains four unique story IDs: the existing Cowboy ID plus the three new IDs.
- Each new story has exactly 10 ordered pages and exactly four questions.
- Every page has a unique page ID, title, non-empty narration, and valid asset name.
- Every question has two choices, exactly one correct choice, and a valid page reference.
- The approved story and response text matches the design exactly, apart from Swift escaping.

### Assets

- All three new asset directories resolve from the selected book.
- Each directory contains exactly `cover.png` and `page-01.png` through `page-10.png`.
- No new book displays the old generated placeholder/fallback art when its real asset exists.

### Behavior

- Library opens and all four covers are selectable.
- Every new story opens the correct cover and can be paged both directions.
- Page 10 completes safely without hard-coded indexing.
- Each review question shows the intended reference image.
- Correct and wrong choices produce the intended visual and spoken feedback.
- Closing/switching never leaves old narration speaking.
- Parent history shows the correct title, duration/completion, and review accuracy per story.

### Regression boundary

- Open the existing Cowboy book, turn at least one page, and confirm its art/narration still work.
- Launch Hidden Objects once and confirm it still enters its existing flow.
- Do not perform or rewrite a broad whole-project audit unless a shared regression points there.

## Verification commands and evidence

Run the strongest checks available in the environment. On a Mac with Xcode/Swift Playgrounds available, build the direct package and launch it on an iPad or iPad simulator. If the current machine cannot compile an iOS application, state that boundary explicitly instead of claiming a successful build.

At minimum, provide evidence for:

- changed-file list;
- exact asset count/names for the three directories;
- catalog invariants and question-reference validation;
- search showing no new hard-coded Cowboy resource path or `pages[9]` dependency;
- build/test result, including the exact command and any platform limitation;
- short manual result for each of the three books.

## Handoff format

When finished, report:

1. what changed;
2. files changed;
3. checks run and results;
4. any remaining limitation;
5. a reminder that the next verifier must use `docs/THREE_NEW_STORIES_VERIFICATION_HANDOFF.md` and stay inside its scope.
