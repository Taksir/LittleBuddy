# Next-chat handoff

## Project

- Name: Ask & Find
- Local workspace: D:\Google Drive Mythoss\Artificial Intelligence\local ollama models\SpeechTherapy
- GitHub: https://github.com/Taksir/Littlebuddy
- Target audience: children ages 3–5
- Direct test target: AskAndFind.swiftpm in Swift Playgrounds on iPadOS 17+

## Current direct-iPad activities

### Find Hidden Objects

- Ten illustrated scenes with ten normalized target boxes per scene.
- One spoken target at a time; each session selects 3–5.
- Temporary object crop after three misses.
- Precise location marker and advance after five misses.
- Existing local progress and parent metrics remain functional.

### Story Time

- Home screen has a second activity card.
- Story: The Cowboy Who Cried Tiger.
- Cover plus ten catalog-backed pages and exact approved text.
- Bidirectional swipe and arrow navigation.
- Replayable AVSpeechSynthesizer narration with cancellation on page changes.
- Four two-choice review questions using referenced story pages.
- Wrong answers receive a specific spoken correction and guided correct choice.
- Separate local StorySessionRecord storage under
  askAndFind.playground.storySessions.v1.
- Parent dashboard summarizes both activity stores and resets both together.
- Cover and page-01 through page-10 are bundled as 1536 x 1024 PNG storybook art
  under Sources/AppModule/Resources/Stories/cowboy-who-cried-tiger/v1/.
- The code-generated artwork path remains only as a missing-asset fallback.

## Native Xcode implementation

The native SpeechTherapy/Xcode target is not synchronized with this Story Time pass.
The direct Swift Playgrounds package is the implementation target for this task.

## Verification status

- Confirmed the package contains the Story Time catalog, four questions, separate
  reader/review state, progress store, manifest, and activity navigation.
- Confirmed Swift source delimiter counts are balanced on Windows.
- Confirmed the Story Time manifest parses as JSON and all eleven referenced PNG
  assets are present at 1536 x 1024.
- Windows does not have Swift or Apple SDKs, so final compilation must happen in
  Swift Playgrounds on the iPad.

## Recommended iPad test

1. Commit and push the repository changes.
2. Download a fresh ZIP on the iPad.
3. Open AskAndFind.swiftpm in Swift Playgrounds.
4. Tap Story Time.
5. Test Read, forward navigation, backward navigation, replay, page 10 completion,
   all four questions, wrong-answer correction, Read Again, Home, and parent reset.
6. Regression-test Find Hidden Objects and its three-miss crop hint.

If Swift Playgrounds reports an error, copy the complete compiler message and the
file/line number into the next task. Do not infer successful iPad compilation from
Windows-only static checks.
