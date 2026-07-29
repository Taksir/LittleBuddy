# Implementation status

Implemented in source:

- SwiftUI iPad app shell, landscape lock, child home, parent gate, parent dashboard,
  and settings.
- Ten built-in scene records, each with ten normalized target hit regions.
- Deterministic selection of a maximum of five objects per play.
- Audio-first prompts using Apple's local English speech synthesizer as the development
  voice backend.
- Gentle miss responses, a visual hand/halo hint after three misses, and demonstration
  after five misses.
- SwiftData append-only local learning-event store and parent metric calculation.
- Unit tests for catalog validity, selection, hit geometry, and metric outcomes.
- No Gemini client dependency, child data collection, microphone, network call, or
  secret file access.

Not yet production-ready:

- Human-reviewed illustration and narration asset pack. The current source renders
  original code-native demo scenes and uses device speech, so it is suitable for
  functional testing rather than final art/voice approval.
- Physical iPad/simulator build verification. The current Windows workspace has no
  Swift/Xcode toolchain. Generate the Xcode project with:

```bash
xcodegen generate --spec XcodeGen.yml
```

Then open `AskAndFind.xcodeproj` on a Mac and run the `AskAndFind` test scheme.
