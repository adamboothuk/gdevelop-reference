# GDevelop Window And Resolution Reference

Extracted from `WindowExtension.cpp`. Extension ID: `BuiltinWindow`.

> Most entries add `AddCodeOnlyParameter("currentScene", "")` first. Do not
> include that internal parameter in JSON `parameters[]`.

## Open This File When

- the task changes fullscreen, window size, or game resolution
- the task reads screen or window dimensions
- the task changes the window title or icon
- the task configures adaptive resolution resizing

## Actions

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `SetFullScreen` | yes/no, keepAspectRatio(optional) |
| ACTION | `SetWindowMargins` | top, right, bottom, left |
| ACTION | `SetGameResolutionSize` | width, height |
| ACTION | `SetWindowSize` | width, height, alsoUpdateResolution |
| ACTION | `CenterWindow` | none |
| ACTION | `SetGameResolutionResizeMode` | resizeMode |
| ACTION | `SetAdaptGameResolutionAtRuntime` | yes/no |
| ACTION | `SetWindowIcon` | imageName |
| ACTION | `SetWindowTitle` | title |

Notes:

- `SetFullScreen` optionally takes a second `yesorno` parameter controlling aspect ratio for HTML5.
- `SetGameResolutionResizeMode` accepts `adaptWidth`, `adaptHeight`, or `""` to disable resizing.
- `SetWindowSize` only works on platforms that allow resizing native windows.

## Conditions

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `IsFullScreen` | none |

## Expressions

| Type | Name | Parameters |
|------|------|------------|
| EXPRESSION | `SceneWindowWidth` | none |
| EXPRESSION | `SceneWindowHeight` | none |
| EXPRESSION | `ScreenWidth` | none |
| EXPRESSION | `ScreenHeight` | none |
| EXPRESSION | `ColorDepth` | none |
| STR_EXPRESSION | `WindowTitle` | none |

## JSON Examples

Enable fullscreen while keeping aspect ratio:

```json
{
  "type": { "value": "SetFullScreen" },
  "parameters": ["yes", "yes"]
}
```

Resize the game window and also update the resolution:

```json
{
  "type": { "value": "SetWindowSize" },
  "parameters": ["1280", "720", "yes"]
}
```
