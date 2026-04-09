# ArrayTools Extension Capture (2026-04-09)

## Extension

- Name: ArrayTools
- Category: Common Extension
- Status: Capturing
- Owner: Codex + user
- Date: 2026-04-09

## Source Of Truth

- Extension export JSON: `C:\GameDev\Skills\Extension Exports\ArrayTools.json`
- Project JSON spot-checks: not yet captured

## Evidence Collected

From `ArrayTools.json`:

- Extension version: `3.0.1`
- Total extension functions: `93`
- Function type counts:
  - `Action`: 39
  - `Condition`: 6
  - `Expression`: 18
  - `ExpressionAndCondition`: 21
  - `StringExpression`: 9
- `eventsBasedBehaviors`: `0`
- `eventsBasedObjects`: `0`

This means:
- There are no behavior modifiers to capture for this extension.
- Coverage can be metadata-first using export function definitions.

## Sampling Strategy (Large Extension)

Use minimal JSON spot-checking instead of complete examples:

1. Capture 1 action sample from project JSON.
2. Capture 1 condition sample from project JSON.
3. Capture 1 expression sample from project JSON.
4. Capture 1 expression-and-condition sample from project JSON.
5. Capture 1 string expression sample from project JSON.

If all 5 match expected serialization patterns, treat remaining entries as
covered by export metadata unless contradictory evidence appears.

## Ready For Reference File?

- [x] Function catalog extracted from export JSON
- [x] Parameter signatures extracted from export JSON
- [x] Behavior modifier section assessed (none for this extension)
- [ ] Spot-check serialization samples collected from project JSON
