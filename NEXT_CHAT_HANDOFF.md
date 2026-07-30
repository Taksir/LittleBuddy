# Next-chat handoff

## Project

- Name: Ask & Find
- Local workspace: D:\Google Drive Mythoss\Artificial Intelligence\local ollama models\SpeechTherapy
- GitHub: https://github.com/Taksir/Littlebuddy
- Target audience: children ages 3–5
- First activity: audio-first hidden-object finding
- Language: English only for version 1

## Current product behavior

- The guide asks for one object at a time using spoken audio.
- No target list is displayed.
- Every scene has ten annotated objects; each session selects 3–5.
- Correct taps receive gentle praise.
- Incorrect taps receive calm encouragement.
- On miss three, a cropped picture of the requested object pops up for 2.4 seconds,
  disappears, and returns the child to searching. It does not show the location.
- On miss five, a tight location marker demonstrates the object and advances.
- Parent-gated progress shows sessions, time, completions, independent success,
  hints, attempts, and recent sessions.

## Direct iPad implementation

- Package: AskAndFind.swiftpm/
- Runs in Apple's Swift Playgrounds app on iPadOS 17 or newer.
- Uses SwiftUI, AVSpeechSynthesizer, and UserDefaults.
- Bundles ten original 1536×1024 PNG storybook scenes under
  Sources/AppModule/Resources/Scenes/.
- SceneCatalog.swift contains 100 hand-tuned normalized target boxes.
- Views.swift renders real scene assets and crops the current target for hints.
- GameEngine.swift controls the temporary cue and precise fifth-miss demonstration.
- Setup instructions: IPAD_DIRECT_SETUP.md

## Native Xcode implementation

- Source: SpeechTherapy/
- Tests: SpeechTherapyTests/
- Project specification: XcodeGenRuntime.yml
- Generate on a Mac with xcodegen generate --spec XcodeGenRuntime.yml.
- Uses SwiftData for progress.
- It has not yet been synchronized with the new artwork and hint implementation.

## Privacy and secrets

- The iPad clients do not call Gemini and contain no API key.
- gem_api.txt exists outside the project and was never read or copied.
- No microphone, child voice, camera, account, ads, analytics, or location.
- .gitignore excludes common secret, Xcode, and Swift Package build artifacts.

## Verification status

- Confirmed ten PNG resources and 100 target definitions.
- Confirmed every scene image name resolves to a bundled PNG.
- Confirmed no placeholder scene backdrop or emoji-object layer remains in the
  direct-iPad package.
- Windows has no Swift/Apple toolchain, so this version still requires compilation
  and runtime testing in Swift Playgrounds on the iPad.

## Recommended next actions

1. Review git status, commit, and push the new package and artwork.
2. Download a fresh repository ZIP on the iPad.
3. Open AskAndFind.swiftpm in Swift Playgrounds and tap Run App.
4. Test all ten scenes over several sessions, especially third- and fifth-miss cues.
5. Report any object whose tap box or crop is too loose or too tight.

## Prompt for the next chat

    Read NEXT_CHAT_HANDOFF.md and inspect the current repository before acting.
    Continue the Ask & Find project from its present state. I am testing
    AskAndFind.swiftpm in Swift Playgrounds on my iPad. First check git status and
    the actual package files.
