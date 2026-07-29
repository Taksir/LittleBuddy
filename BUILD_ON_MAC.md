# Build Ask & Find on a Mac

This project is a native SwiftUI iPad app. Its source is complete in this workspace,
but Xcode/iPad simulators are not available in the Windows authoring environment.

1. Install current Xcode and Xcode command-line tools on a Mac.
2. Install XcodeGen: `brew install xcodegen`.
3. From this folder run `xcodegen generate`.
4. Open `AskAndFind.xcodeproj` in Xcode.
5. Set a unique Apple bundle id in `project.yml` before signing.
6. Select an iPad simulator, then run the `AskAndFind` scheme and its tests.

The app has no Gemini client dependency and no secret requirement. Do not add
`gem_api.txt` to this project or its Xcode target.

## Current asset implementation

The initial release code uses original code-rendered storybook scenes and a bundled
catalog of ten scenes with ten normalized target regions each. Replace the renderer
with human-reviewed licensed art only after importing the same target ids and
coordinates into a versioned content pack.
