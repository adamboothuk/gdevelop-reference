# Extension Capture Template

Copy this template to a new file when starting an extension, for example:

`docs/captures/2026-04-08-sticker-capture.md`

---

## Extension

- Name:
- Category:
- Status: `Capturing`
- Owner:
- Date:

## Source Of Truth

- Editor capture location (project/scene/event):
- JSON sample file path:
- GDevelop source link (optional):
- Wiki documentation link:
- Extension install shape:
  - [ ] Split `eventsFunctionsExtensions/<extension>.json` file (preferred)
  - [ ] Inline `eventsFunctionsExtensions` object in project JSON
  - [ ] Inline install used with documented reason:
  - [ ] Not checked

## Verified Entries

### Actions

| UI Label | Internal `type.value` | Parameter Order | Evidence |
|---|---|---|---|
|  |  |  |  |

### Conditions

| UI Label | Internal `type.value` | Parameter Order | Evidence |
|---|---|---|---|
|  |  |  |  |

### Expressions

| UI Label | Internal Name | Parameter Order | Evidence |
|---|---|---|---|
|  |  |  |  |

## Behavior Modifiers (Events-Based Behaviors)

If the extension defines `eventsBasedBehaviors`, capture modifier/toggle
properties from behavior `propertyDescriptors`.

| Behavior | Property Name | UI Label | Type | Default | Runtime Impact Evidence |
|---|---|---|---|---|---|
|  |  |  |  |  |  |

## Notes / Gotchas

- Deprecated names:
- Behavior-scoped naming rules:
- Missing items to verify:
- Test/validation result:
  - [ ] Static source metadata only
  - [ ] Saved project JSON serialization checked
  - [ ] GDevelop/editor or preview behavior checked

## Ready For Reference File?

- [ ] At least one verified action/condition/expression recorded
- [ ] Parameter order validated
- [ ] Behavior modifiers captured (if behavior-based extension)
- [ ] Runtime impact of modifiers checked in inline code (`_get...()` usage)
- [ ] Install shape documented
- [ ] Saved project JSON evidence captured, or gap explicitly recorded
- [ ] Evidence links or file paths recorded
- [ ] Safe to draft `references/extensions/<extension-name>.md`
