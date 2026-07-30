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
- **Story Time**: a four-book library with The Cowboy Who Cried Tiger, The Tortoise
  and the Hare, The Lion and the Mouse, and The Fox and the Grapes.
- Every story has a cover, ten narrated pages, forward/back navigation, replayable
  English narration, and four picture-based review questions with specific spoken
  correction.
- Story Time assets are bundled offline under
  Sources/AppModule/Resources/Stories/<story-id>/v1/ as cover.png and
  page-01.png through page-10.png.

Progress is stored locally in separate Hidden Objects and Story Time stores. The
parent dashboard resolves each story title from its saved story ID and can reset
both stores together.
