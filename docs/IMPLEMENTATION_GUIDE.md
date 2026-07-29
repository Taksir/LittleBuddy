# Engineering Implementation Guide

## 1. Mandate

Implement the design in the linked documents as a native iPad application. Do not
add unrequested features. Preserve privacy, offline reliability, deterministic game
rules, modular feature boundaries, and the one-target-at-a-time learning model.

This guide is written so a capable engineering agent can execute it without making
product decisions implicitly. When a decision remains genuinely open, record it in
an ADR and choose the smallest reversible option.

## 2. Required reading order

1. `README.md`
2. `docs/PRODUCT_AND_UX.md`
3. `docs/ARCHITECTURE.md`
4. `docs/CONTENT_PIPELINE.md`
5. This file

Before implementation, confirm the latest stable Xcode/Swift toolchain and verify
that the selected minimum iPadOS version supports the intended test devices. Model
ids and API quotas must be rechecked against official Google documentation.

## 3. Non-negotiable constraints

- Do not read or embed `gem_api.txt` in the iPad target.
- Do not call Gemini from the iPad client.
- Do not add microphone, camera, account, location, advertising, tracking, or social
  capabilities.
- Do not source launch artwork from unlicensed web search results.
- Do not use a language model for hit-testing or gameplay decisions.
- Do not show a target image or list before the visual-hint threshold.
- Do not show more than five requested targets in one scene play.
- Do not count control taps as attempts.
- Do not describe parent summaries as diagnosis or therapy outcomes.
- Do not move to the next milestone while required tests for the current milestone
  fail.

## 4. Milestone plan

### M0 — Repository and decision records

Deliverables:

- Initialize the Xcode project and source repository.
- Add formatting/lint configuration only if it runs locally and does not complicate
  builds.
- Create ADRs for minimum iPadOS, persistence choice, image rendering mode, and
  content-pack signature approach.
- Add CI that builds and runs unit tests without Gemini credentials.
- Add secret patterns and generated content staging to `.gitignore`.

Gate:

- Clean build on a fresh checkout.
- CI requires no secret for normal app tests.
- No API key string or secret file appears in the repository or app bundle.

### M1 — Domain and deterministic state machine

Deliverables:

- Content/domain value types.
- Gameplay reducer/state machine.
- Target selector with injected seeded random source.
- Coordinate transform and hit-test engine.
- Learning event types.
- Pure parent metric calculator.

Tests:

- Every legal state transition.
- Ignored/illegal events.
- Hint begins on third miss.
- Demonstration begins on configured maximum miss.
- Correct-before-hint vs assisted classification.
- Replay does not increment attempts.
- Aspect-fit transforms across representative iPad sizes.
- Selection is limited to five and reproducible by seed.
- Metric formulas and edge cases.

Gate: all M1 unit tests pass without UI, persistence, network, or audio.

### M2 — Content loader and validation

Deliverables:

- Versioned manifest decoder.
- Checksum and invariant validation.
- One developer fixture scene with ten synthetic/owned targets.
- Graceful error path for invalid content.
- Developer-only content validation command.

Tests:

- Missing file, invalid checksum, bad coordinates, wrong target count, duplicate id,
  and unsupported schema all fail explicitly.
- Valid pack loads identically offline.

Gate: corrupt content can never start a broken child session.

### M3 — Child gameplay vertical slice

Deliverables:

- App shell and child home.
- Hidden-object scene rendering.
- Audio guidance and replay.
- Tap feedback, correct animation, three-miss hint, demonstration, completion.
- Reduce Motion behavior.
- Lifecycle pause/resume behavior.

Tests:

- UI test completes one target independently.
- UI test reaches the third-miss hint.
- UI test demonstrates and advances after the maximum misses.
- Rapid taps cannot double-complete.
- Control taps do not count as misses.
- Airplane-mode/manual offline run succeeds.

Gate: a child can complete a fixture scene using audio and touch only.

### M4 — Persistence and parent dashboard

Deliverables:

- SwiftData event/session store.
- Local settings.
- Parent gate.
- Seven-day, thirty-day, and all-time summaries.
- Recent session list and object-level trends with minimum-sample threshold.
- Reset progress.

Tests:

- Persistence migration fixture.
- Parent gate blocks child access.
- Dashboard matches pure metric-calculator fixtures.
- Reset deletes progress but not bundled content.
- Background time is excluded from active play time.

Gate: all displayed metrics can be traced to documented formulas.

### M5 — Launch content pack

Deliverables:

- Ten rights-cleared scenes.
- Ten annotated candidates per scene.
- Reviewed prompt, response, hint, and completion audio.
- Rights records, checksums, manifests, and review sign-offs.
- Physical-iPad QA report.

Gate:

- Automated pack validator passes.
- Two-adult review checklist passes for every scene.
- No placeholder or unlicensed production asset remains.

### M6 — Hardening and release readiness

Deliverables:

- Accessibility audit.
- Performance/memory pass on the oldest supported iPad.
- Privacy manifest and privacy policy inputs.
- Kids Category/parental-gate review.
- App Store metadata review.
- Failure-mode and interruption testing.
- Security scan confirming no secrets or unapproved SDKs.

Gate:

- Product acceptance criteria in `PRODUCT_AND_UX.md` pass.
- Legal/privacy review is recorded; architecture documentation is not legal advice.

## 5. Test matrix

| Area | Minimum cases |
|---|---|
| Devices | Smallest supported iPad, common 10–11-inch iPad, 12.9/13-inch iPad |
| Orientation | Landscape left/right; verify controlled response to portrait if landscape is locked |
| Connectivity | Online, airplane mode, network loss during launch |
| Audio | Normal, replay spam, interruption, mute/low volume, missing/corrupt clip |
| Input | Correct tap, 1–5 misses, rapid multi-tap, edge of hit box, letterbox, chrome tap |
| Lifecycle | Background/foreground during prompt, hint, success, and completion |
| Accessibility | VoiceOver chrome, Reduce Motion, increased text size in parent area, contrast |
| Content | All 100 target regions on physical device, every transcript/audio pairing |
| Metrics | Empty, partial, independent, assisted, demonstrated, abandoned, resumed |
| Privacy | No permissions requested, no network in play loop, reset progress, parent gate |

## 6. Definition of done for a target round

- The target is selected from the persisted session plan.
- Approved audio asks for it exactly once, with replay available.
- No target image/list reveals the answer.
- Hit testing uses normalized geometry and the aspect-fit transform.
- Each counted miss receives feedback and emits one event.
- The third miss emits one `hintShown` event and displays the visual hint.
- Completion is correctly classified as independent, assisted, or demonstrated.
- Audio/animation is cancelled safely on navigation or backgrounding.
- The next round begins only once.
- Unit and UI tests cover the flow.

## 7. Engineering quality rules

- Prefer value types and explicit state over shared mutable singletons.
- Inject clocks, random sources, repositories, and audio services for testing.
- Keep views declarative; business logic belongs in state/reducer/domain services.
- Use structured concurrency and cancellation; avoid unstructured detached tasks.
- Treat content decoding/validation failures as typed errors.
- Keep metric functions pure and deterministic.
- Avoid external packages unless Apple frameworks cannot reasonably satisfy the need.
- Add accessibility identifiers to all controls and target test fixtures.
- Do not log secrets, raw child interaction histories, or audio transcripts as runtime
  telemetry.
- Document any deliberate deviation from this design in an ADR.

## 8. Content-tool implementation order

The developer-only tool is a separate target/package and may be implemented after
the app accepts a hand-written fixture manifest:

1. Schema validator.
2. Image metadata and checksum command.
3. Rectangle annotation UI.
4. Polygon refinement and device preview.
5. Audio attachment/transcript checker.
6. Rights record checker.
7. Gemini text adapter.
8. Gemini TTS adapter.
9. Human approval workflow.
10. Immutable packager/signature.

Only steps 7–8 may access `GEMINI_API_KEY`. They must require an explicit authoring
command and must never run during Xcode build, test, app launch, or CI without a
separately configured secret.

## 9. Review questions that must be answered before release

- Which actual iPad models must be supported?
- Is prompt text visible by default or only in parent-enabled co-play mode?
- Which auditioned voice and accent does the product owner approve?
- Is the visual hint a hand plus halo, or halo only in reduced-stimulation mode?
- Does the parent want multiple local child profiles? Version 1 currently assumes a
  single anonymous local learner; adding profiles changes metrics and privacy UX.
- Has counsel/privacy review approved the Kids Category disclosures and policy?

None of these blocks M1/M2 domain work. The voice choice, art approval, and device
matrix must be fixed before M5/M6 release gates.

## 10. Suggested first engineering prompt

```text
Read README.md and every file in docs/ in the prescribed order. Implement milestone
M0 and M1 only. Do not implement UI, network calls, Gemini integration, or production
content. Use SwiftUI project structure, pure deterministic domain types, an injected
seeded random source, normalized aspect-fit hit testing, an append-only event model,
and unit tests for every M1 gate. Do not read or copy gem_api.txt. Report any design
conflict before expanding scope, and finish by running the complete test suite.
```
