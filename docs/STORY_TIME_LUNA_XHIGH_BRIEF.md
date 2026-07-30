# Luna xHigh Engineering Brief — Story Time

## Mission

Implement the Story Time activity described in
docs/STORY_TIME_DESIGN.md while preserving the existing direct-iPad Hidden Objects
experience. Do not redesign the approved story, safety treatment, question wording,
or privacy boundary without explicit product-owner approval.

## Required reading

Before changing code, read:

1. docs/STORY_TIME_DESIGN.md
2. docs/ARCHITECTURE.md
3. docs/PRODUCT_AND_UX.md
4. NEXT_CHAT_HANDOFF.md
5. AskAndFind.swiftpm/Package.swift
6. all Swift files under AskAndFind.swiftpm/Sources/AppModule

Inspect git status first. Preserve unrelated user changes.

## Target implementation

The immediate target is the self-contained AskAndFind.swiftpm package that runs in
Swift Playgrounds on iPadOS 17+. Do not require a Mac, server, API key, account, or
network connection.

The native SpeechTherapy Xcode implementation may be synchronized in a separate
task. Do not mix the two implementations accidentally.

## Architectural constraints

Create a real second feature rather than adding story state to GameEngine or
StorybookSceneView.

Recommended package layout:

    Sources/AppModule/
      AppShell/
        HomeView.swift
        AppRouter.swift
      Features/
        HiddenObjects/
        StoryTime/
          StoryModels.swift
          StoryCatalog.swift
          StoryReaderEngine.swift
          StoryReaderView.swift
          StoryReviewEngine.swift
          StoryReviewView.swift
          StoryProgressStore.swift
      Core/
        Audio/
        Progress/
        DesignSystem/
      Resources/
        Scenes/
        Stories/

A full directory migration is optional if it introduces risk. The mandatory
boundaries are:

- Story Time does not import or mutate hidden-object engine state.
- Hidden Objects does not import Story Time.
- AppState or an AppRouter owns cross-feature navigation.
- Shared speech cancellation and playback behavior live behind a small service.
- Story content is immutable data, not hard-coded throughout views.
- Views render state and send intents; engines own transitions.

## Suggested domain types

    ActivityDescriptor
    StoryBook
    StoryPage
    StoryQuestion
    StoryChoice
    StoryReaderState
    StoryReaderEngine
    StoryReviewState
    StoryReviewEngine
    StorySessionRecord
    StoryProgressStore

Use stable string ids for stories, pages, questions, and choices. Persist content
version with each session so later story revisions do not corrupt metrics.

## Delivery sequence

### Phase 1 — App shell

- Add a Story Time activity card beside Find Hidden Objects.
- Extend routing for story library, reader, and review.
- Verify Hidden Objects behavior and parent gate remain unchanged.

### Phase 2 — Content model

- Implement manifest-backed or catalog-backed story data.
- Add the approved cover, ten pages, transcripts, and four questions.
- Validate unique ids, contiguous page order, asset existence, and one correct choice
  per question.

If final art or recorded narration is not yet available, use clearly named local
placeholder assets. Do not download web images or silently substitute a different
story. Keep asset names final so placeholders can be replaced without code changes.

### Phase 3 — Reader

- Implement bidirectional swipe and arrow navigation.
- Use a 3:2 art region with a separate SwiftUI text card.
- Cancel stale narration on every page transition.
- Replay visible-page narration from the beginning.
- Implement Reduce Motion behavior.
- Save and restore the active page within an unfinished session.

### Phase 4 — Review

- Show the referenced page again for each question.
- Present exactly two large picture choices.
- Implement the approved specific confirmation and correction lines.
- After a wrong choice, teach and require the correct choice.
- Auto-reveal after a second wrong choice.
- Never use a red X, score pressure, lives, or failure screen.

### Phase 5 — Progress

- Add StorySessionRecord or normalized story events.
- Keep existing hidden-object records readable.
- Add parent summary cards without presenting diagnostic interpretations.
- Ensure Reset Progress removes both activity histories after confirmation.

### Phase 6 — Verification

- Add deterministic unit tests for reader and review reducers.
- Add content validation tests.
- Add UI tests for forward/backward page turns, replay cancellation, completion,
  wrong-answer correction, correct answer, and review completion.
- Run a regression session through Hidden Objects.

## Audio contract

The initial runtime may use AVSpeechSynthesizer with the exact approved transcript.
Design the API so reviewed bundled audio can replace TTS without changing reader
state.

Required behaviors:

- one narration channel;
- new page cancels old page;
- replay restarts current page;
- backgrounding stops or pauses safely;
- stale completion callbacks are ignored;
- speech never blocks page navigation;
- no microphone permission;
- no Gemini credential or network call in the app.

## Resource contract

Use:

    Sources/AppModule/Resources/Stories/cowboy-who-cried-tiger/v1/

Expected logical assets:

- cover
- page-01 through page-10
- two answer-choice cues for each of four questions
- optional reviewed narration clips
- manifest containing exact transcripts and alt text

Swift Package resources must be declared in Package.swift and loaded from
Bundle.module.

## Persistence migration

Do not overwrite or reinterpret askAndFind.playground.sessions.v1. Add a separate
versioned Story Time key or introduce a backward-compatible aggregate store.

Suggested first key:

    askAndFind.playground.storySessions.v1

Story record fields:

    id
    storyID
    contentVersion
    startedAt
    endedAt
    lastPageIndex
    storyCompleted
    narrationReplayCount
    reviewCompleted
    questionsPresented
    firstTryCorrect
    correctedAfterHelp
    durationSeconds

## Test matrix

- New story opens at page 1.
- Continue resumes an unfinished page.
- Previous and next buttons enforce boundaries.
- Swipe works in both directions.
- Rapid swipes never overlap voices.
- Replay does not change progress.
- Home exit saves without marking completion.
- Page 10 completion is recorded exactly once.
- Review cannot begin before story completion.
- Answer taps are ignored outside awaitingChoice.
- Correct first answer logs independent.
- Wrong then correct logs correctedAfterHelp.
- Two wrong taps reveal and explain the answer.
- Reduced Motion removes slide, pulse, and shake.
- Missing art gives a calm recoverable state.
- Hidden Objects still launches, speaks, scores taps, hints, and saves progress.
- Parent reset clears both stores.

## Definition of done

- Code builds in Swift Playgrounds on the target iPad.
- Existing Hidden Objects regression flow passes.
- The complete ten-page story can be read forward and backward offline.
- All exact text and review lines match the approved design.
- Four questions reuse their referenced story images.
- Audio does not overlap.
- Progress survives relaunch and appears in the parent area.
- No secret, microphone permission, analytics SDK, web image, or runtime AI call is
  introduced.
- README and NEXT_CHAT_HANDOFF.md accurately describe the delivered implementation.

## Implementation conduct

Work in small verified slices. After each phase, inspect the actual diff and run the
relevant tests. Do not claim iPad compilation from Windows-only static checks. If the
Apple toolchain is unavailable, state that explicitly and hand back exact iPad
verification steps.
