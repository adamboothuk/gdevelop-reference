# Extension Knowledge Test Strategy

The purpose of extension testing is not only to prove that a GDevelop project
can export. The main risk is whether a fresh agent can use this skill to select
the right extension and serialize its actions, conditions, expressions, and
behavior properties correctly.

Use layered tests. Each layer catches a different failure mode.

## Layer 1: Reference Completeness

Goal: confirm the reference page has enough information for another agent to
use the extension without prior context.

For each extension reference, check:

- selection guidance: when to use the extension instead of custom events
- install/setup guidance: required object behaviors, resources, variables, or
  project extension installation
- action catalog: internal `type.value`, parameter order, and example
- condition catalog: internal `type.value`, parameter order, and example
- expression catalog: expression name, parameter order, and example expression
- behavior properties: property names, defaults, and runtime meaning
- known gaps: entries marked source-derived or needs serialized verification

This can be automated with markdown lint-style checks once each reference uses a
stable section template.

## Layer 2: Serialization Evidence

Goal: confirm the documented JSON names and parameter order match saved
GDevelop project JSON.

For each extension, keep a small set of validation cases in AI-Playground.
The baseline is up to three entries per available usage type:

- up to three representative actions
- up to three representative conditions
- up to three representative expressions
- up to three string expressions when the extension has them
- up to three object or behavior properties when the extension defines them
- one edge case for the extension's main value proposition

The automation should inspect saved project JSON and produce evidence such as:

```text
Extension: ArrayTools
Install shape: inline eventsFunctionsExtensions object
Scene: ArrayTools Testing
Instruction: ArrayTools::HasNumber
Parameters: [...]
Evidence file: C:\GameDev\AI-Playground\AI Playground.json
```

This is the most important evidence for agent reliability.

## Scenario Format

Each validation scenario should use this structure:

```md
## Scenario: <extension> <short behavior name>

Goal:
<Plain-language behavior the agent must build.>

Required extension:
<Extension name>

Usage coverage:
- Actions: <up to three expected actions>
- Conditions: <up to three expected conditions>
- Expressions: <up to three expected expressions>
- Object or behavior properties: <up to three expected properties>

Required test objects:
- <object name, type, layer, position, visible label/marker>

Required variables:
- Global: <existing test global variables to use or modify>
- Scene: <scene variables to create or modify>
- Object: <object variables to create or modify>

Expected visible result:
<What a human should see in the test scene. Use labels, counters, markers, or
debug panels so the result is inspectable.>

Expected saved JSON evidence:
- <type.value or expression pattern>
- <parameter order expectation>

Automated checks:
- <JSON evidence checks>
- <Playwright/browser smoke checks>
- <optional DOM/canvas/debug-text checks>

Human review prompt:
<Question to ask when visual judgement is required, for example "Does the
screen shake visibly when the marker is hit?">

Known limits:
<What cannot be proven automatically yet.>
```

## Test Objects And Visibility

Some extension tests require objects, and the GDevelop reference skill is
expected to support creating and placing them.

Use visible test objects whenever possible:

- place objects in a predictable region of the first test scene
- give each object a clear name, such as `ArrayTools_ResultLabel` or
  `FireBullet_TestTarget`
- use text labels or debug panels to show pass/fail state
- use distinct colors, positions, and layers for objects that a human reviewer
  must inspect
- avoid relying only on invisible variable changes when a visual result can be
  made cheaply

For non-visual logic extensions, expose state through a text object or debug
variable display. For visual effects such as screen shake, camera movement, or
particle-like behavior, include a human review prompt.

## Variables

Some scenarios require variables. AI-Playground includes test global variables
for validation work; use those where appropriate instead of inventing unrelated
project state.

Scenarios must specify:

- whether a variable is global, scene, or object scope
- whether it already exists in AI-Playground or must be created
- initial value
- expected value after the scenario runs
- where the result is displayed or recorded

If the current project JSON does not expose the needed variable clearly, the
agent must create it deliberately in the test fixture or ask for clarification.

## Human Judgement

Some extension behavior cannot be fully validated by static JSON or basic
browser smoke tests. Examples include:

- screen shake intensity
- camera feel
- animation smoothness
- visual polish of generated UI controls
- whether a projectile pattern "looks right"

For these cases, automation should still do everything it can:

- confirm the extension is installed
- confirm the expected instructions/properties are serialized
- export and load the build
- expose the test visibly in the scene

Then the scenario should ask a focused human review question. Keep the question
binary or short-answer when possible:

```text
Human review: When pressing Space, does the camera visibly shake for about one
second without moving the UI layer?
```

## Layer 3: Agent Task Simulation

Goal: test whether a fresh low-context agent can use only the skill reference to
implement a requested behavior.

Use small scenario prompts, for example:

- "Use ArrayTools to check whether a scene array contains a number, then reverse
  the array."
- "Use FireBullet to configure a weapon object, fire toward a target, and check
  whether it has just fired."

The expected output should be a project JSON patch or event snippet. A reviewer
or script checks:

- extension was selected rather than recreated manually
- correct `type.value` values were used
- parameters are in the documented order
- required variables/objects/behaviors are created or explicitly requested
- test objects are visible when human review is required
- test variables use the documented global/scene/object scope
- no undocumented identifiers were invented

Automating the agent itself may come later. Start by storing scenario prompts
and expected JSON patterns in the repo.

## Layer 4: Export And Runtime Smoke

Goal: catch export errors, missing generated files, browser console errors, and
obvious runtime failures.

Current automation:

```powershell
.\scripts\invoke-extension-validation.ps1 -ExtensionName ArrayTools
.\scripts\invoke-extension-validation.ps1 -ExtensionName ArrayTools -ExportHtml5 -UseNpxGdexporter
npx playwright test
```

The Playwright smoke test checks:

- exported page loads
- canvas exists
- no console errors
- no page errors
- no failed requests

This does not prove gameplay correctness. It proves the generated project is at
least loadable after extension use.

## Recommended Definition Of Ready For An Extension

An extension task is ready for a fresh agent when it includes:

- direct reviewed JSON source link
- direct wiki page link
- implementation plan
- validation scenario list
- expected validation coverage, for example action/condition/expression/behavior
- instruction to update the backlog task before finishing

## Recommended Definition Of Done For Extension Knowledge

Treat the extension as `Verified` only when:

- reference completeness checks pass
- saved project JSON evidence covers representative actions, conditions, and
  expressions
- behavior properties are covered when applicable
- at least one fresh-agent scenario has been reviewed against the reference
- HTML5 export succeeds
- Playwright smoke test passes
- remaining gaps are explicitly documented
