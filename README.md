# Ask & Find

Ask & Find is an audio-first learning app for children ages 3–5. The child can
search illustrated scenes for hidden objects or listen to a short story and answer
picture-based questions.

## Run directly on an iPad — no Mac required

Use the self-contained [AskAndFind.swiftpm](AskAndFind.swiftpm) package with Apple's
free **Swift Playgrounds** app:

1. Install **Swift Playgrounds** from the iPad App Store.
2. Open https://github.com/Taksir/Littlebuddy in Safari.
3. Choose **Code → Download ZIP**.
4. Extract the ZIP in the Files app.
5. Open Swift Playgrounds and tap **Browse**.
6. Open the extracted repository and select AskAndFind.swiftpm.
7. Wait for compilation, then tap **Run App**.

This requires iPadOS 17 or newer and runs full screen inside Swift Playgrounds. See
[direct iPad setup](IPAD_DIRECT_SETUP.md) for compact instructions.

## Native Xcode build on a Mac

The original SwiftUI/Xcode source remains available for simulator, device, and later
App Store work. On a Mac:

    git clone https://github.com/Taksir/Littlebuddy.git
    cd Littlebuddy
    brew install xcodegen
    xcodegen generate --spec XcodeGenRuntime.yml
    open AskAndFind.xcodeproj

In Xcode, select the AskAndFind target, choose an Apple signing team, replace the
placeholder bundle identifier, select an iPad or iPad simulator, and press Command-R.

## Activities

### Find Hidden Objects

The guide asks for one object at a time. Each session selects 3–5 targets from a
storybook scene. Incorrect taps receive gentle encouragement; after three misses the
requested object appears as a temporary crop, and after five misses a precise marker
demonstrates its location.

### Story Time

Story Time contains **The Cowboy Who Cried Tiger**:

- cover plus ten narrated pages;
- forward and backward swipe or arrow navigation;
- replayable offline narration using the caring English voice fallback;
- four picture-based questions after the story;
- specific spoken correction after a wrong choice;
- local story-session progress in the parent view.

The story's tiger consequence is narrated but shown off-screen without graphic
imagery. The package includes a cover and ten full-resolution cartoon storybook
illustrations under
AskAndFind.swiftpm/Sources/AppModule/Resources/Stories/cowboy-who-cried-tiger/v1/.
The built-in drawing fallback remains only as protection if an asset is ever missing.

## Parent area

Tap **For grown-ups** and complete the arithmetic gate. The dashboard summarizes both
activities, including sessions, completions, independent answers, corrected answers,
questions, attempts, and recent play. Reset clears both local activity stores.

## Privacy

- Progress stays on the device.
- No microphone, child voice recording, account, advertising, analytics, or location.
- No Gemini client or API key is included in the iPad app.
- Runtime play works offline after installation.

## Repository structure

    AskAndFind.swiftpm/     Direct-iPad Swift Playgrounds app
    SpeechTherapy/          Native SwiftUI/Xcode source
    SpeechTherapyTests/     Native target unit tests
    docs/                   Product, Story Time, and architecture specifications
    XcodeGenRuntime.yml     Xcode project definition to use on a Mac

Useful Story Time references:

- [Story Time design](docs/STORY_TIME_DESIGN.md)
- [Luna xHigh engineering brief](docs/STORY_TIME_LUNA_XHIGH_BRIEF.md)
- [Direct iPad setup](IPAD_DIRECT_SETUP.md)

No open-source license has been selected. Until one is added, the source is
copyrighted by its owner and no reuse rights are granted automatically.
