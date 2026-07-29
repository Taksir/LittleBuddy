# Run on an iPad simulator

Use the final project specification, not the older draft spec:

```bash
brew install xcodegen
xcodegen generate --spec XcodeGenRuntime.yml
open AskAndFind.xcodeproj
```

In Xcode, select the `AskAndFind` scheme and an iPad simulator, then run tests with
`Command-U`. Before installing to a real device, replace the placeholder bundle id
`com.example.askandfind` in `XcodeGenRuntime.yml` and select the appropriate signing
team.

The app is deliberately offline and has no Gemini key or network requirement.
