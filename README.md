# Ask & Find

Ask & Find is an audio-first hidden-object learning game for children ages 3–5. The
child hears one object request at a time, searches the picture, and taps the answer.
Incorrect taps receive calm encouragement; the third miss reveals a gentle visual
hint. A parent area summarizes local play and success data.

## Choose how to run it

### Directly on an iPad — no Mac required

Use the self-contained [AskAndFind.swiftpm](AskAndFind.swiftpm) package with Apple's
free **Swift Playgrounds** app:

1. Install **Swift Playgrounds** from the iPad App Store.
2. Open `https://github.com/Taksir/Littlebuddy` in Safari.
3. Choose **Code → Download ZIP**.
4. Extract the ZIP in the Files app.
5. Open Swift Playgrounds and tap **Browse**.
6. Open the extracted repository and select `AskAndFind.swiftpm`.
7. Wait for compilation, then tap **Run App**.

This requires iPadOS 17 or newer. It runs full screen inside Swift Playgrounds. See
[direct iPad setup](IPAD_DIRECT_SETUP.md) for the compact instructions.

### Native Xcode build on a Mac

The original SwiftUI/Xcode source remains available for simulator, device, and later
App Store work. On a Mac:

```bash
git clone https://github.com/Taksir/Littlebuddy.git
cd Littlebuddy
brew install xcodegen
xcodegen generate --spec XcodeGenRuntime.yml
open AskAndFind.xcodeproj
```

In Xcode, select the `AskAndFind` target, choose an Apple signing team, replace the
placeholder bundle identifier, select an iPad or iPad simulator, and press
`Command-R`. Run tests with `Command-U`.

## How to play

1. Launch the app and tap **Find Hidden Objects**.
2. Listen to the spoken request, such as “Can you find the bunny?”
3. Tap the matching object.
4. A correct tap gives gentle praise and advances to the next object.
5. An incorrect tap gives encouragement and lets the child try again.
6. After the third miss, a glowing halo and hand pointer show where to look.
7. After five misses, the guide demonstrates the object and moves on.
8. Tap the speaker button to repeat the current request.

Each session asks for 3–5 objects, one at a time. The app never displays the full
target list.

## Parent area

Tap **For grown-ups** and complete the arithmetic gate. The dashboard shows sessions,
active time, completed objects, independent success, hints, attempts, and recent
play. Parents can choose 3–5 targets, enable written prompts for co-play, enable
reduced movement, or reset local progress.

## Current implementation

- Ten demo scenes with ten normalized hit regions per scene.
- One audio-requested target at a time.
- Gentle feedback, visual hint after three misses, demonstration after five.
- Local progress storage and parent summaries.
- No microphone, advertising, analytics, child account, Gemini client, or API key.
- Native Xcode project plus a self-contained Swift Playgrounds package.

## Artwork status

The repository does not yet contain final PNG, JPEG, or WebP scene artwork. The
prototype renders code-generated backgrounds and emoji objects. These functional
scenes test gameplay, coordinates, speech, hints, and progress tracking, but final
release work must replace them with reviewed, rights-cleared storybook illustrations
and approved narration.

## Repository structure

```text
AskAndFind.swiftpm/     Direct-iPad Swift Playgrounds app
SpeechTherapy/          Native SwiftUI/Xcode source
SpeechTherapyTests/     Native target unit tests
docs/                   Product and architecture specifications
XcodeGenRuntime.yml     Xcode project definition to use on a Mac
```

The older `project.yml` and `XcodeGen.yml` files are design-history drafts. Use
`XcodeGenRuntime.yml` for the native Mac/Xcode path.

## Privacy and secrets

- Progress stays locally on the device in the current versions.
- No child voice, images, identifiers, location, ads, or analytics are collected.
- Gemini is not called by either app client.
- Never add an API key to Swift source, package manifests, plist files, or GitHub.
- App Store release requires separate privacy and Kids Category review.

## Documentation

- [Direct iPad setup](IPAD_DIRECT_SETUP.md)
- [Product and interaction specification](docs/PRODUCT_AND_UX.md)
- [Software architecture](docs/ARCHITECTURE.md)
- [Content and annotation pipeline](docs/CONTENT_PIPELINE.md)
- [Engineering implementation guide](docs/IMPLEMENTATION_GUIDE.md)
- [Implementation status](IMPLEMENTATION_STATUS.md)

## License

No open-source license has been selected. Until one is added, the source is
copyrighted by its owner and no reuse rights are granted automatically.
