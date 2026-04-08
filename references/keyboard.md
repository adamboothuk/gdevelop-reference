# GDevelop Keyboard Reference

Extracted from `KeyboardExtension.cpp`. Extension ID: `BuiltinKeyboard`.

> All entries add `AddCodeOnlyParameter("currentScene", "")` first. Do not
> include that internal parameter in JSON `parameters[]`.

## Open This File When

- the task checks whether a keyboard key is down, just pressed, or released
- the task needs the exact keyboard condition name for JSON
- the task needs the expression for the last pressed key

## Conditions

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `KeyPressed` | key |
| CONDITION | `KeyReleased` | key |
| CONDITION | `KeyFromTextPressed` | keyboardKey |
| CONDITION | `KeyFromTextJustPressed` | keyboardKey |
| CONDITION | `KeyFromTextReleased` | keyboardKey |
| CONDITION | `AnyKeyPressed` | none |
| CONDITION | `AnyKeyReleased` | none |

Notes:

- `KeyPressed` and `KeyReleased` are hidden older forms.
- Prefer `KeyFromTextPressed`, `KeyFromTextJustPressed`, and `KeyFromTextReleased` when authoring new JSON.
- The keyboard-based conditions do not work with on-screen mobile keyboards; use mouse or touch references for touch-first input flows.

## Expressions

| Type | Name | Parameters |
|------|------|------------|
| STR_EXPRESSION | `LastPressedKey` | none |

## JSON Examples

Check whether the Space key is held:

```json
{
  "type": { "value": "KeyFromTextPressed" },
  "parameters": ["\"Space\""]
}
```

Check whether the Left key was just pressed:

```json
{
  "type": { "value": "KeyFromTextJustPressed" },
  "parameters": ["\"Left\""]
}
```
