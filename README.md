# Ask & Find

Ask & Find is an audio-first hidden-object learning game for children ages 3–5. It
runs as a native SwiftUI app on iPadOS 17 or newer.

The child hears one object request at a time and taps the scene to answer. Incorrect
taps receive calm encouragement. After three misses, the app displays a visual halo
and hand pointer. A parent-gated dashboard summarizes local usage and success data.

## Current implementation

- Ten built-in demo scenes, each with ten normalized target regions.
- Up to five objects selected for each play session.
- One spoken target at a time; no visible target list.
- Local English speech using `AVSpeechSynthesizer`.
- Gentle miss feedback, visual hint after three misses, demonstration after five.
- Local SwiftData progress storage and parent dashboard.
- No microphone, advertising, analytics, child account, Gemini client, or API key.

## Artwork status

The repository currently contains no final PNG, JPEG, or WebP artwork. The functional
prototype renders code-generated backgrounds and emoji objects. These scenes make
gameplay, coordinate hit-testing, hints, and progress tracking testable, but they are
not production artwork. Final release work must replace them with reviewed,
rights-cleared storybook illustrations and approved narration clips.

## Repository structure

```text
SpeechTherapy/          SwiftUI app source
SpeechTherapyTests/     Unit tests
docs/                   Product and architecture specifications
XcodeGenRuntime.yml     Xcode project definition to use
```

The older `project.yml` and `XcodeGen.yml` files are design-history drafts. Use
`XcodeGenRuntime.yml`.

## Requirements

- Windows for editing and GitHub operations.
- A Mac with Xcode for compiling/signing the iPad app.
- XcodeGen 2.38 or newer.
- iPadOS 17 or newer.
- An Apple Account signed into Xcode.

Apple requires Xcode on macOS to compile and sign native iPad apps. Windows cannot
run this SwiftUI target directly.

## Push changes from Windows

This project is already connected to `https://github.com/Taksir/Littlebuddy` on the
`main` branch. For future changes:

```powershell
git status
git add .
git commit -m "Describe the change"
git push
```

Before committing, confirm secrets are absent:

```powershell
git status
git ls-files | Select-String -Pattern "gem_api|\.env|\.key|\.pem|DerivedData"
```

That final command should produce no output. Never copy `gem_api.txt` into this
repository.

## Install on the MacBook

Clone the repository:

```bash
git clone https://github.com/Taksir/Littlebuddy.git
cd Littlebuddy
```

Install Xcode from the Mac App Store. If Homebrew is installed, install XcodeGen:

```bash
brew install xcodegen
```

Generate and open the Xcode project:

```bash
xcodegen generate --spec XcodeGenRuntime.yml
open AskAndFind.xcodeproj
```

In Xcode:

1. Select the `AskAndFind` application target.
2. Open **Signing & Capabilities**.
3. Select your Apple Account or Personal Team.
4. Replace `com.example.askandfind` with a unique bundle identifier.
5. Connect the iPad by USB and tap **Trust** if prompted.
6. Select the iPad as the run destination.
7. Press `Command-R`.

If Xcode asks for it, enable **Settings → Privacy & Security → Developer Mode** on
the iPad, restart it, reconnect it, and run again. Run tests with `Command-U`.

## How to play on the iPad

1. Launch **Ask & Find** from the iPad home screen.
2. Tap **Find Hidden Objects**.
3. Listen to the caring voice ask for one object, such as “Can you find the bunny?”
4. Tap the matching object in the scene.
5. A correct tap produces gentle praise and advances to the next object.
6. An incorrect tap produces encouragement and lets the child try again.
7. After the third miss, a glowing halo and hand pointer show where to look.
8. After five misses, the guide demonstrates the object and moves on so the child
   never becomes stuck.
9. Tap the speaker button to hear the current request again.
10. Tap the home button to leave play.

The app asks for up to five objects in a session. It does not show all target objects
in a list, so the child must listen and search. Progress is saved locally.

## Parent dashboard

From the home screen, tap **For grown-ups** and complete the arithmetic gate. The
dashboard shows sessions, active play time, objects completed, first-try success,
independent success, hints, average attempts, and recent sessions. Settings allow a
parent to choose 3–5 targets per picture, enable written prompts for co-play, or
enable reduced movement.

## Privacy and secrets

- Progress stays on the iPad in this version.
- No child voice, images, identifiers, location, ads, or analytics are collected.
- Gemini is not called by the iPad client.
- Never add an API key to Swift source, plist files, or GitHub.
- App Store release requires separate privacy and Kids Category review.

## Documentation

- [Product and interaction specification](docs/PRODUCT_AND_UX.md)
- [Software architecture](docs/ARCHITECTURE.md)
- [Content and annotation pipeline](docs/CONTENT_PIPELINE.md)
- [Engineering implementation guide](docs/IMPLEMENTATION_GUIDE.md)
- [Implementation status](IMPLEMENTATION_STATUS.md)

## License

No open-source license has been selected. Until one is added, the source is
copyrighted by its owner and no reuse rights are granted automatically.
