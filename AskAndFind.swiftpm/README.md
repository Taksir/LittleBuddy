# Ask & Find — iPad Swift Playgrounds package

This folder is a self-contained Swift Playgrounds app package. It is the version to
open directly on an iPad when no Mac is available.

## Run on iPad

1. Install **Swift Playgrounds** from the iPad App Store.
2. In Safari, open https://github.com/Taksir/Littlebuddy.
3. Download the repository ZIP using **Code → Download ZIP**.
4. Open the Files app and tap the downloaded ZIP to extract it.
5. Open Swift Playgrounds.
6. Tap **Browse** on the welcome screen.
7. Navigate into the extracted repository folder.
8. Tap the AskAndFind.swiftpm folder.
9. Wait while Swift Playgrounds resolves and compiles the package.
10. Tap the **Run App** triangle to play full screen.

The package requires iPadOS 17 or newer. It does not require Xcode, XcodeGen, a Mac,
a Gemini key, or a network connection after the repository has been downloaded.

## Play behavior

- The guide asks for one object at a time.
- A session randomly selects 3–5 targets from the ten objects annotated in the scene.
- After three misses, an enlarged crop of the requested object appears briefly and
  then disappears; it does not reveal where the object is.
- After five misses, a tight location marker demonstrates the answer and play moves on.
- Progress is stored locally for the parent dashboard.

## Artwork

The package bundles ten original 1536×1024 storybook illustrations in
Sources/AppModule/Resources/Scenes. SceneCatalog.swift contains 100 normalized target
regions that drive both tap detection and the cropped visual cue.

## Updating the iPad copy

After changes are pushed to GitHub, download a fresh repository ZIP and replace the
old extracted package. Progress belongs to that local Playgrounds app package; keep
the old package until you are comfortable losing its saved session history.
