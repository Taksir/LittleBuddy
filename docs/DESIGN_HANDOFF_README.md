# Hidden Object Learning App — Design Handoff

This workspace contains the product and software design for an English-language,
audio-first iPad learning app for children ages 3–5. It intentionally contains no
application implementation.

The first release contains one child-facing activity: **Find Hidden Objects**.
The app speaks one target at a time, evaluates taps locally, responds gently, and
reveals a visual hint after three misses. Each scene has ten annotated candidate
objects, while a play session chooses at most five and never displays a target list.

Start here:

1. [Product and interaction specification](docs/PRODUCT_AND_UX.md)
2. [Software architecture](docs/ARCHITECTURE.md)
3. [Content and annotation pipeline](docs/CONTENT_PIPELINE.md)
4. [Implementation handoff and acceptance criteria](docs/IMPLEMENTATION_GUIDE.md)

## Fixed decisions

- Native iPad app, landscape-first, using SwiftUI.
- English only in version 1; localization seams are preserved.
- One spoken target at a time; no visible target tray.
- Up to five requested objects per scene, drawn from ten annotated candidates.
- Visual hint begins after the third incorrect tap.
- A parent-gated dashboard shows usage and learning progress.
- No microphone, child speech capture, advertising, third-party analytics, account,
  chat, camera, or location in version 1.
- The Gemini API key is never compiled into or sent to the iPad app.
- Initial artwork must be original, commissioned, public-domain, or licensed for
  redistribution. Random Google Image results are not acceptable content sources.

## Status

Design only. An engineering agent should follow the milestone gates in
`docs/IMPLEMENTATION_GUIDE.md` and should not silently expand version-1 scope.
