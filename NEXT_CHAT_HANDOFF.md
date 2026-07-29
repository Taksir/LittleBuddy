# Next-chat handoff

## Project

- Name: Ask & Find
- Local workspace: `D:\Google Drive Mythoss\Artificial Intelligence\local ollama models\SpeechTherapy`
- GitHub: `https://github.com/Taksir/Littlebuddy`
- Target audience: children ages 3–5
- First activity: audio-first hidden-object finding
- Language: English only for version 1

## Product behavior

- The guide asks for one object at a time using spoken audio.
- No target list is displayed.
- Each scene contains ten candidate objects; a session selects 3–5.
- Correct taps receive gentle praise.
- Incorrect taps receive calm encouragement.
- The third miss displays a halo and hand-pointer hint.
- The fifth miss demonstrates the object and advances.
- Parent-gated progress shows sessions, time, completions, independent success,
  hints, attempts, and recent sessions.

## Implementations

### Direct iPad version

- Package: `AskAndFind.swiftpm/`
- Runs in Apple's Swift Playgrounds app on iPadOS 17 or newer.
- Does not require a Mac or Xcode.
- Uses SwiftUI, `AVSpeechSynthesizer`, and `UserDefaults` progress storage.
- Contains ten code-rendered demo scenes and 100 normalized target regions.
- Open `AskAndFind.swiftpm` from Swift Playgrounds and tap Run App.
- Setup instructions: `IPAD_DIRECT_SETUP.md`

### Native Xcode version

- Source: `SpeechTherapy/`
- Tests: `SpeechTherapyTests/`
- Final project specification: `XcodeGenRuntime.yml`
- Generate on a Mac with `xcodegen generate --spec XcodeGenRuntime.yml`.
- This version uses SwiftData for progress storage.

## Current visual/audio limitation

- There are no final PNG/JPEG/WebP storybook scenes.
- Both implementations currently render code-generated backgrounds and emoji objects.
- Runtime speech uses Apple's local English synthesizer, not reviewed Gemini-generated
  narration clips.
- Production work still needs ten rights-cleared illustrations, verified coordinates,
  and reviewed caring adult narration.

## Privacy and secrets

- The iPad clients do not call Gemini and contain no API key.
- `gem_api.txt` exists outside the project and was never read or copied.
- No microphone, child voice, camera, account, ads, analytics, or location.
- `.gitignore` excludes common secret, Xcode, and Swift Package build artifacts.

## Verification performed

- Native source received structural/static checks on Windows.
- Direct Swift Playgrounds package received static checks:
  - eight Swift files;
  - ten scenes;
  - one `@main` entry point;
  - balanced braces;
  - no secret references.
- No Apple toolchain exists on the Windows machine, so neither target has been compiled
  by Xcode or Swift Playgrounds yet.
- The first Swift Playgrounds run on the iPad is the required compiler/runtime test.

## Git state at handoff

The following latest work was created/modified locally and may still need committing
and pushing:

- `.gitignore`
- `README.md`
- `IPAD_DIRECT_SETUP.md`
- `AskAndFind.swiftpm/`
- `NEXT_CHAT_HANDOFF.md`

Before continuing, run `git status` to confirm the actual state. Do not assume these
changes are already on GitHub.

## Recommended next actions

1. Commit and push the direct-iPad package.
2. Download the repository ZIP on the iPad.
3. Open `AskAndFind.swiftpm` in Swift Playgrounds.
4. Capture the complete compiler error list if it does not build.
5. Fix and retest until the app launches and completes a full five-object session.
6. After functional validation, create and annotate final illustration assets.

## Prompt for the next chat

```text
Read NEXT_CHAT_HANDOFF.md and inspect the current repository before acting. Continue
the Ask & Find project from its present state. I am testing AskAndFind.swiftpm in
Swift Playgrounds on my iPad. Preserve the privacy and gameplay decisions. First check
git status and the actual package files; do not assume the latest work was pushed.
```
