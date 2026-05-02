# ArrayTools Extension Capture (2026-04-09)

## Extension

- Name: ArrayTools
- Category: Common Extension
- Status: Drafted
- Owner: Codex + user
- Date: 2026-04-09

## Source Of Truth

- Extension export JSON: `C:\GameDev\Skills\Extension Exports\ArrayTools.json`
- Reviewed source JSON: `GDevelopApp/GDevelop-extensions/extensions/reviewed/ArrayTools.json`
- Wiki documentation: https://wiki.gdevelop.io/gdevelop5/extensions/array-tools/
- Validation project for future spot-checks: `C:\GameDev\AI-Playground`
- Validation install shape: split reference in `AI Playground.json` to
  `/eventsFunctionsExtensions/arraytools`, with extension JSON stored at
  `C:\GameDev\AI-Playground\eventsFunctionsExtensions\arraytools.json`.

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

Additional parity evidence:

- Official documentation includes technical notes for internal JSON type names
  and hidden/internal parameter slots:
  - https://wiki.gdevelop.io/gdevelop5/extensions/array-tools/
- Real project JSON confirms scene-level serialized `type.value` forms such as:
  - `ArrayTools::AppendAll`
  - `ArrayTools::HasString`
  - `ArrayTools::Shift`
- The local validation project contains an exported ArrayTools JSON copy and a
  split installed extension file.
- `AI Playground.json` contains serialized ArrayTools event usage for:
  - `ArrayTools::HasNumber`
  - `ArrayTools::Reverse`
- The split install was exported to HTML5 with gdexporter and passed Playwright
  smoke with 1 canvas, 0 console errors, 0 page errors, and 0 failed requests.

## Sampling Strategy (Large Extension)

Use minimal JSON spot-checking instead of complete examples:

1. Capture 1 action sample from project JSON.
2. Capture 1 condition sample from project JSON.
3. Capture 1 expression sample from project JSON.
4. Capture 1 expression-and-condition sample from project JSON.
5. Capture 1 string expression sample from project JSON.

If all 5 match expected serialization patterns, treat remaining entries as
covered by export metadata unless contradictory evidence appears.

Expanded validation target set:

- Scene-variable action: `ArrayTools::AppendAll`
- Scene-variable condition: `ArrayTools::HasString`
- Scene-variable expression: `ArrayTools::Sum(...)`
- Scene-variable expression-and-condition: `ArrayTools::IndexOf(...)`
- Scene-variable string expression: `ArrayTools::Join(...)`
- Object-variable entry with object/object-variable pairs:
  `ArrayTools::ObjectAppendAll`
- Global-variable entry: `ArrayTools::GlobalAppendAll`

## Ready For Reference File?

- [x] Function catalog extracted from export JSON
- [x] Parameter signatures extracted from export JSON
- [x] Behavior modifier section assessed (none for this extension)
- [x] Draft reference file updated with source/wiki-backed guidance
- [ ] Spot-check serialization samples collected from project JSON
- [ ] Validation pass defined and completed
