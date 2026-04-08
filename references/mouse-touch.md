# GDevelop Mouse And Touch Reference

Extracted from `MouseExtension.cpp`. Extension ID: `BuiltinMouse`.

> Most entries add `AddCodeOnlyParameter("currentScene", "")` first. Do not
> include that internal parameter in JSON `parameters[]`.
>
> Cursor and touch position entries that use a layer default the layer to `""`
> and the camera number to `0`.

## Open This File When

- the task touches mouse cursor position
- the task uses touch input or multitouch
- the task needs mouse wheel or mouse button identifiers
- the task needs the correct JSON parameter order for `BuiltinMouse`

## Cursor Actions

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `TouchSimulateMouse` | yes/no |
| ACTION | `CenterCursorHorizontally` | none |
| ACTION | `CenterCursorVertically` | none |
| ACTION | `HideCursor` | none |
| ACTION | `ShowCursor` | none |
| ACTION | `SetCursorPosition` | x, y |
| ACTION | `CenterCursor` | none |

Notes:

- `TouchSimulateMouse` defaults to `yes` and controls whether touches also move the mouse cursor.
- Deprecated hidden aliases exist for several cursor actions, such as `CentreSourisX`, `CentreSourisY`, `SetSourisXY`, and `CentreSouris`.

## Cursor Position Conditions And Expressions

These use standard numeric comparison parameters for conditions:

- condition form: operator, value, layer, cameraNumber
- expression form: layer, cameraNumber

| Type | Name | Parameters |
|------|------|------------|
| CONDITION and EXPRESSION | `CursorX` | operator/value or layer, cameraNumber |
| CONDITION and EXPRESSION | `CursorY` | operator/value or layer, cameraNumber |
| CONDITION and EXPRESSION | `MouseOnlyCursorX` | operator/value or layer, cameraNumber |
| CONDITION and EXPRESSION | `MouseOnlyCursorY` | operator/value or layer, cameraNumber |

Notes:

- `CursorX` and `CursorY` include touch input when touch-to-mouse simulation is enabled.
- `MouseOnlyCursorX` and `MouseOnlyCursorY` are hidden and are mostly intended for extension internals.
- Deprecated hidden aliases include `MouseX`, `MouseY`, `SourisX`, and `SourisY`.

## Mouse Wheel And Canvas

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `IsMouseWheelScrollingUp` | none |
| CONDITION | `IsMouseWheelScrollingDown` | none |
| CONDITION | `IsMouseInsideCanvas` | none |
| EXPRESSION | `MouseWheelDelta` | none |

Use `MouseWheelDelta` when the task needs the amount of scrolling rather than a simple up/down test.

## Mouse Buttons

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `MouseButtonPressed` | button |
| CONDITION | `MouseButtonReleased` | button |
| CONDITION | `MouseButtonFromTextPressed` | button |
| CONDITION | `MouseButtonFromTextReleased` | button |

Notes:

- `MouseButtonPressed` and `MouseButtonReleased` are hidden older forms that use the `mouse` parameter type.
- `MouseButtonFromTextPressed` and `MouseButtonFromTextReleased` are the visible string-based forms and should be preferred.
- These conditions also treat touch input as mouse input when touch-to-mouse simulation is active.

## Multitouch Position

Touch-specific position entries add the touch identifier first.

Condition form:

- touchId, operator, value, layer, cameraNumber

Expression form:

- touchId, layer, cameraNumber

| Type | Name | Parameters |
|------|------|------------|
| CONDITION and EXPRESSION | `TouchX` | touchId, operator/value or layer, cameraNumber |
| CONDITION and EXPRESSION | `TouchY` | touchId, operator/value or layer, cameraNumber |

## Touch Start And End

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `HasAnyTouchOrMouseStarted` | none |
| EXPRESSION | `StartedTouchOrMouseCount` | none |
| EXPRESSION | `StartedTouchOrMouseId` | touchIndex |
| CONDITION | `HasTouchEnded` | touchId |

Deprecated hidden multitouch entries:

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `PopStartedTouch` | none |
| CONDITION | `PopEndedTouch` | none |
| CONDITION | `HasAnyTouchStarted` | none |
| EXPRESSION | `StartedTouchCount` | none |
| EXPRESSION | `StartedTouchId` | touchIndex |
| EXPRESSION | `LastTouchId` | none |
| EXPRESSION | `LastEndedTouchId` | none |

## JSON Examples

Enable touch-to-mouse simulation:

```json
{
  "type": { "value": "TouchSimulateMouse" },
  "parameters": ["yes"]
}
```

Set the cursor position:

```json
{
  "type": { "value": "SetCursorPosition" },
  "parameters": ["400", "300"]
}
```

Check whether the left mouse button is held:

```json
{
  "type": { "value": "MouseButtonFromTextPressed" },
  "parameters": ["\"Left\""]
}
```

Check the X position of touch `0` on the base layer:

```json
{
  "type": { "value": "TouchX" },
  "parameters": ["0", ">=", "100", "\"\"", "0"]
}
```
