# Ask & Find — iPad Swift Playgrounds package

This folder is a self-contained Swift Playgrounds app package for iPadOS 17 or
newer. It does not require Xcode, a Mac, a Gemini key, or a network connection after
download.

## Run on iPad

1. Install **Swift Playgrounds** from the iPad App Store.
2. In Safari, open https://github.com/Taksir/Littlebuddy.
3. Choose **Code → Download ZIP**.
4. Extract the ZIP in the Files app.
5. Open Swift Playgrounds and tap **Browse**.
6. Open the extracted repository and select AskAndFind.swiftpm.
7. Wait for compilation and tap **Run App**.

## Included activities

- **Find Hidden Objects**: audio-first object finding with gentle miss feedback,
  temporary object-picture help after three misses, and precise demonstration after
  five misses.
- **Story Time**: cover plus ten narrated pages for The Cowboy Who Cried Tiger,
  reversible page navigation, replayable narration, and four picture-based review
  questions with spoken corrections.

Story Time includes a full set of eleven 1536 x 1024 storybook illustrations under
Sources/AppModule/Resources/Stories/cowboy-who-cried-tiger/v1/: cover.png and
page-01.png through page-10.png. SwiftUI continues to render all story text so the
artwork remains reusable and free of baked-in labels.

Progress is stored locally in separate Hidden Objects and Story Time stores. The
parent dashboard can reset both stores together.
