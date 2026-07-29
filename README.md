# Ask & Find

Ask & Find is an audio-first hidden-object learning game for children ages 3–5. It
is a native SwiftUI iPad app designed around listening comprehension, visual
scanning, object-word association, and gentle feedback.

The child hears one object request at a time and taps the scene to answer. Incorrect
taps receive calm encouragement. After three misses, the app displays a visual halo
and hand pointer. A parent-gated dashboard summarizes local usage and success data.

## Current implementation

- Native SwiftUI app targeting iPadOS 17 or newer.
- Landscape iPad interface.
- Ten built-in demo scene records.
- Ten annotated candidate objects per scene using normalized coordinates.
- Up to five objects selected for each play session.
- One spoken target at a time; no visible object list.
- Local English speech using `AVSpeechSynthesizer`.
- Visual hint after three misses and demonstration after five misses.
- Local SwiftData progress storage.
- Parent gate, progress dashboard, settings, and progress reset.
- Unit tests for content validation, selection, hit testing, and parent metrics.
- No microphone, advertising, analytics, child account, Gemini client, or API key in
  the iPad application.

## Important artwork status

The repository does **not** yet contain final PNG, JPEG, or WebP scene artwork. The
current functional prototype renders simple code-generated backgrounds and emoji
objects. These demo scenes make gameplay, coordinates, hints, and progress tracking
testable, but they are not production artwork.

Final release work must replace the demo renderer with ten human-reviewed,
rights-cleared storybook illustrations and approved narration clips. The content and
coordinate contracts are already separated so artwork can be replaced without
rewriting the game rules.

## Repository structure

```text
SpeechTherapy/
  App/                 Application entry and navigation state
  AppShell/            Home, parent gate, dashboard, and settings
  Core/                Audio, content catalog, and persistence
  Domain/              Content models, validation, coordinates, selection
  Features/            Hidden-object gameplay and presentation
  RuntimeSources/      Corrected source files selected by the final project spec
  Resources/           iPad application property list
SpeechTherapyTests/    Unit tests
docs/                  Product, architecture, content, and implementation designs
XcodeGenRuntime.yml    Final Xcode project definition
```

`XcodeGenRuntime.yml` is the project specification to use. The older `project.yml`
and `XcodeGen.yml` files are retained as design-history drafts and should not be used
to generate the current app target.

## Requirements

- A Mac capable of running a current supported version of Xcode.
- Xcode and its iPadOS SDK.
- XcodeGen 2.38 or newer.
- An iPad running iPadOS 17 or newer.
- An Apple Account signed into Xcode for device signing.

Windows can be used to edit the repository and push it to GitHub, but Apple requires
Xcode on macOS to compile and sign a native iPad app.

## Push from Windows to GitHub

The current folder is not yet a Git repository.

### 1. Create the GitHub repository

On GitHub, create a new empty repository, for example `ask-and-find`. Do not add a
README, `.gitignore`, or license during creation because those files already exist
locally. Choose public or private visibility as appropriate.

### 2. Open PowerShell in this folder

```powershell
Set-Location -LiteralPath "D:\Google Drive Mythoss\Artificial Intelligence\local ollama models\SpeechTherapy"
```

### 3. Initialize and review the local repository

```powershell
git init
git add .
git status
```

Confirm that `gem_api.txt`, `.env`, key files, build output, and `DerivedData` are not
listed. The Gemini key currently resides outside this project and must remain there.

### 4. Commit the project

```powershell
git commit -m "Initial Ask and Find iPad app"
git branch -M main
```

If Git asks for your identity first:

```powershell
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR_GITHUB_EMAIL"
git commit -m "Initial Ask and Find iPad app"
```

### 5. Connect and push

Replace the placeholders with your GitHub username and repository name:

```powershell
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
git push -u origin main
```

Git Credential Manager normally opens a browser for GitHub authentication. GitHub
does not accept an account password for command-line Git operations; use the browser
sign-in flow or a personal access token if requested.

For later changes:

```powershell
git add .
git commit -m "Describe the change"
git push
```

## Build and install from the MacBook

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
cd YOUR_REPOSITORY
```

For a private repository, sign in to GitHub when prompted.

### 2. Install the build tools

Install Xcode from the Mac App Store, open it once, and allow it to install required
components. If Homebrew is installed, install XcodeGen with:

```bash
brew install xcodegen
```

### 3. Generate and open the Xcode project

```bash
xcodegen generate --spec XcodeGenRuntime.yml
open AskAndFind.xcodeproj
```

### 4. Configure signing

In Xcode:

1. Select the `AskAndFind` project and application target.
2. Open **Signing & Capabilities**.
3. Select your Apple Account or Personal Team.
4. Replace `com.example.askandfind` with a unique bundle identifier such as
   `com.yourname.askandfind`.

### 5. Install on the iPad

1. Connect the iPad to the MacBook with USB and tap **Trust** if prompted.
2. Select the connected iPad as Xcode's run destination.
3. Press the Run button or `Command-R`.
4. If requested, enable **Settings → Privacy & Security → Developer Mode** on the
   iPad, restart it, reconnect, and run again.

Run unit tests with `Command-U` before relying on the build.

## Privacy and secrets

- Never copy `gem_api.txt` into this repository.
- Never add a Gemini or other API key to Swift source, plist files, or GitHub.
- Progress data remains on the iPad in the current version.
- The app does not collect child voice, images, identifiers, or location.
- Production App Store release still requires privacy and Kids Category review.

## Design documentation

- [Product and interaction specification](docs/PRODUCT_AND_UX.md)
- [Software architecture](docs/ARCHITECTURE.md)
- [Content and annotation pipeline](docs/CONTENT_PIPELINE.md)
- [Engineering implementation guide](docs/IMPLEMENTATION_GUIDE.md)
- [Implementation status](IMPLEMENTATION_STATUS.md)

## License

No open-source license has been selected. Until a license is added, the source is
copyrighted by its owner and no reuse rights are granted automatically.
