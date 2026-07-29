# Product and Interaction Specification

## 1. Product definition

### Audience

- Primary user: a child aged 3–5.
- Secondary user: a parent or caregiver reviewing progress and managing settings.
- Initial language: English only.
- Primary input: touch.
- Primary instruction channel: spoken audio.

### Version-1 learning goal

Help the child practice listening comprehension, visual scanning, object-word
association, sustained attention, and gentle recovery after an incorrect choice.
This is an educational game, not a diagnostic or medical instrument. Parent metrics
must be described as observations, not clinical scores.

### Version-1 scope

The child home screen contains one activity card: **Find Hidden Objects**. The app
shell must support later activity modules without requiring the hidden-object
feature to be rewritten.

Not in version 1:

- Speech recognition or microphone access.
- Open-ended conversation with the child.
- A visible list of hidden targets.
- Timers, points, leaderboards, streak pressure, lives, punitive red X marks, or ads.
- Child accounts, names, photos, location, contacts, social sharing, or chat.
- Parent cloud sync or remote analytics.
- Languages other than English.

## 2. Experience principles

1. **Listen first.** The spoken request is the primary cue. Text can be shown in a
   compact prompt card for a nearby adult, but no picture of the requested object
   is shown before the hint.
2. **One goal at a time.** Only the current target is active. No list of all objects
   is exposed.
3. **Errors are safe.** A miss produces a soft sound, a warm spoken response, and no
   penalty.
4. **Help is graduated.** The third miss triggers a visual cue. Assistance is logged
   separately from an independent success.
5. **The scene remains the focus.** Controls stay at the edges and are large enough
   for preschool motor accuracy.
6. **The app remains usable offline.** A network failure must never block a session.
7. **Parents get useful summaries, not surveillance.** Store only local learning
   events needed to calculate understandable progress.

## 3. Child flow

### Launch and home

1. App opens to a calm home screen.
2. A friendly illustrated guide greets the child using a bundled audio clip.
3. The single large activity card says and depicts “Find Hidden Objects.”
4. Tapping it begins or resumes a session. No reading is required.
5. Parent settings require a parental gate.

### Scene setup

1. Choose a scene that is not among the most recently played when possible.
2. Choose up to five targets from the scene's ten validated candidates.
3. Selection balances recent exposure, target difficulty, and prior independent
   success. It must not simply choose the same five each time.
4. Preload the scene image and every audio clip before revealing the scene.
5. Begin with a short orientation line such as “Let’s look carefully.”

### Target loop

For each selected target:

1. The guide speaks: “Can you find the bunny?”
2. The screen shows the scene, a replay-audio button, home button, and an optional
   unobtrusive adult-readable sentence. It does not show a bunny icon or target list.
3. A tap inside the current target's validated hit region is correct.
4. A tap outside it is a miss. Taps on app chrome are controls, not attempts.
5. After success, briefly celebrate the discovered object, speak its name again,
   log the outcome, and advance after a calm pause.
6. After all selected targets are complete, play a short completion celebration and
   offer “another picture” or home using image-and-audio controls.

### Gentle response ladder

| Event | Visual response | Spoken response policy | Log |
|---|---|---|---|
| Correct with 0 misses | Soft glow and small positive animation on object | Specific, brief praise: “You found the bunny!” | `independent` |
| Miss 1 | Very subtle neutral ripple at tap | “Good looking. Try again.” | attempt 1 |
| Miss 2 | Same neutral ripple | “Take your time. Look all around.” | attempt 2 |
| Miss 3 | No red mark; begin hint | “Let me help. Watch here.” | attempt 3 + hint shown |
| Hint | Warm halo around target plus animated storybook hand pointing nearby for 2–3 seconds | Repeat target name once | `visualHint` |
| Correct after hint | Same success animation, slightly quieter | “That’s the bunny. Nice finding.” | `assisted` |
| Continued misses | Repeat a stronger pulse; enlarge only the invisible touch tolerance within safe limits | “The bunny is right here.” | attempts continue |
| Unable to complete | Guide demonstrates by animating the target, then advances | “This is the bunny. Let’s find another one.” | `demonstrated` |

Recommended safety valve: demonstrate and advance after five total misses. This
prevents a child from becoming trapped. Make the threshold remotely configurable in
the content manifest, with three misses remaining the first visual-hint threshold.

### Tap behavior

- Ignore taps during the first 250 ms after a scene appears to prevent accidental
  carryover.
- Debounce repeated taps within approximately 300 ms.
- Do not count taps on home, replay, pause, or parent controls as misses.
- During success/hint animation, queue or ignore scene taps; never advance twice.
- Expand a visually small object's hit box by a configurable motor-accessibility
  inset, but never so far that it overlaps a plausible distractor.
- Map taps through the actual aspect-fit scene rectangle, excluding letterboxing.

## 4. Voice agent

### Persona

Working persona: a calm, caring adult guide with a warm vocal smile. The voice is
gentle rather than babyish, speaks standard English, uses short sentences, and never
expresses disappointment.

Direction for voice generation:

- Adult feminine presentation.
- Warm, patient, reassuring, and clear.
- Approximately 0.85–0.95 of ordinary conversational pace.
- Natural pauses, crisp object names, low intensity.
- Avoid exaggerated excitement, whispering, sarcasm, scolding, or pet names.
- Praise the action, not an identity: “You looked carefully,” not “You’re so smart.”

### Delivery architecture

Use reviewed, pre-generated audio assets for all version-1 child-facing lines. Text
and speech generation can use Gemini during content authoring, but the resulting
transcript and audio must be reviewed by an adult and bundled into a signed content
pack. Runtime playback is deterministic.

Fallback order:

1. Bundled reviewed voice clip.
2. Downloaded and checksum-validated reviewed clip from a future content service.
3. On-device `AVSpeechSynthesizer` using the fixed English fallback text.
4. Never block play because an online voice API is unavailable.

The guide is “agent-like” through state-aware responses and animation, not through
an unrestricted live chat model. No child audio is captured.

### Required version-1 line categories

- Greeting and activity introduction.
- Target question template for every object.
- Replay of current instruction.
- Miss 1, miss 2, and hint-introduction variants.
- Correct-before-hint and correct-after-hint variants.
- Demonstration and move-on line.
- Scene completion and session completion.
- Pause, resume, and calm error/fallback lines.

Each category may have 2–4 approved variants to reduce repetition. Randomization
must be seeded and testable.

## 5. Visual design

- Landscape iPad layout, responsive across supported iPad sizes.
- Original premium 2D storybook scenes with rich but organized detail.
- Central art occupies most of the screen.
- Minimum control target: 60×60 points; prefer 72×72 for child-facing controls.
- Maintain strong contrast and avoid conveying state with color alone.
- Target objects must remain recognizable at the smallest supported iPad size.
- The prompt sentence is optional in child mode and may be enabled for co-play.
- No visible attempt counter is required. If represented, use neutral dots rather
  than hearts/lives, and do not let it feel punitive.
- Respect Reduce Motion by replacing bounce/zoom with opacity and outline changes.
- Replay-audio is always available and cannot count as an error.

## 6. Parent area

### Entry and parental gate

Parent controls are separated from the child play surface. Entry uses an adult task
such as press-and-hold followed by a written instruction; do not use a fixed four-
digit default that a child can learn by observation. External links, data export,
deletion, purchases, and future account actions all remain behind this gate.

### Dashboard

Default period: last 7 days, with 30-day and all-time options.

Show:

- Number of sessions and total active play time.
- Objects attempted and completed.
- Independent success rate: correct before any visual hint.
- First-try success rate.
- Assisted success rate and visual hints used.
- Average attempts per object.
- Completion rate by scene.
- Object-level trend: improving, steady, or needs more practice, only when there is
  enough data to avoid misleading conclusions.
- Recent sessions with date, duration, completed targets, and hints used.

Do not show:

- Medical, developmental, or diagnostic conclusions.
- Comparisons with other children.
- A global “intelligence” score.
- Exact raw tap maps by default.

### Metric definitions

```text
firstTryRate = targets correct with zero prior misses / targets attempted
independentSuccessRate = targets correct before a visual hint / targets attempted
assistedSuccessRate = targets correct after a visual hint / targets attempted
averageAttempts = all scene tap attempts / targets attempted
hintRate = targets that displayed a hint / targets attempted
completionRate = targets completed or demonstrated / targets selected
activePlayTime = foreground time in active gameplay, excluding pauses/background
```

Use minimum-sample thresholds for trends: do not label an object until it has at
least five attempts across at least two sessions.

### Parent controls

- Voice volume and replay behavior.
- Prompt text on/off.
- Maximum targets per scene: 3, 4, or 5; default 5.
- Hint threshold: fixed at 3 in version 1 UI; remotely configurable only for QA.
- Reduced stimulation mode.
- Reset progress with a second confirmation.
- Export a simple local CSV in a future release, behind the parental gate.

## 7. Future feature expansion

Every future child activity must implement a common activity contract:

- Metadata: id, title, icon, age band, availability.
- A SwiftUI entry view.
- A session coordinator that emits normalized learning events.
- A content-pack namespace and schema version.
- Parent metric summaries.
- Optional capability declarations such as audio playback or microphone use.

The app shell owns navigation, parental gates, settings, content catalog, audio,
and progress storage. An activity owns its rules and presentation. Future activities
must not reach into hidden-object internals.

## 8. Product acceptance criteria

- A child can complete a scene using only spoken guidance and touch.
- Only one target is requested at a time, with no target icon/list before hint.
- A scene requests no more than five objects, even though ten candidates are
  annotated.
- The first visual hint begins on the third counted miss.
- Correct and incorrect taps always receive immediate, gentle feedback.
- The next target cannot begin until the prior feedback completes or is safely
  skipped.
- A session works in airplane mode after installation.
- Parent metrics recompute correctly from event records.
- Reset progress removes local child-session records.
- No secret, child audio, personal identifier, ad SDK, or third-party analytics SDK
  exists in the app bundle.
