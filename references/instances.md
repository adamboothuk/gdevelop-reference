# GDevelop Scene Instances JSON Reference

Authoritative reference for editing object placement in a scene or external
layout `instances` array.

## Scope

Use this file when editing:

- `layout.instances` in a scene JSON
- `externalLayout.instances` in an external layout JSON
- per-instance placement and override fields

Primary source files:

- `Core/GDCore/Project/InitialInstance.cpp`
- `Core/GDCore/Project/InitialInstance.h`
- `Core/GDCore/Project/InitialInstancesContainer.cpp`
- `Core/GDCore/Project/Layout.cpp`
- `Core/GDCore/Project/ExternalLayout.cpp`

Verified sample used for common object coverage:

- `C:/GameDev/Dark_Ship/layouts/ai-test.json`

## Container Structure

Scene JSON and external layout JSON both serialize instances as an array:

```json
{
  "instances": [
    {
        "...": "one initial instance"
    }
  ]
}
```

## Minimum Safe Instance Template

This is the smallest practical template that matches current serialization
behavior:

```json
{
  "name": "ObjectName",
  "x": 100,
  "y": 200,
  "zOrder": 0,
  "layer": "",
  "angle": 0,
  "customSize": false,
  "width": 0,
  "height": 0,
  "persistentUuid": "replace-with-uuid-v4",
  "numberProperties": [],
  "stringProperties": [],
  "initialVariables": []
}
```

## Field Reference

| Field | Type | Required in practice | Default when omitted on read | Notes |
|------|------|----------------------|-------------------------------|-------|
| `name` | string | Yes | `""` | Must match an object name in the scene/project object list. |
| `x` | number | Yes | `0` | 2D/3D position X. |
| `y` | number | Yes | `0` | 2D/3D position Y. |
| `z` | number | No | `0` | 3D position Z. Serialized only when non-zero. |
| `zOrder` | integer | Yes | `0` | 2D draw order within a layer. |
| `layer` | string | Yes | `""` | Empty string targets the base layer. |
| `angle` | number | Yes | `0` | Rotation on Z axis. |
| `rotationX` | number | No | `0` | 3D rotation X. Serialized only when non-zero. |
| `rotationY` | number | No | `0` | 3D rotation Y. Serialized only when non-zero. |
| `customSize` | boolean | Yes | `false` | Indicates width/height override. |
| `width` | number | Yes | `0` | Serialized even when `customSize` is `false`. |
| `height` | number | Yes | `0` | Serialized even when `customSize` is `false`. |
| `depth` | number | No | n/a | If present, engine marks custom depth enabled. |
| `opacity` | integer | No | `255` | Serialized only when not `255`. |
| `flippedX` | boolean | No | `false` | Serialized only when `true`. |
| `flippedY` | boolean | No | `false` | Serialized only when `true`. |
| `flippedZ` | boolean | No | `false` | Serialized only when `true`. |
| `locked` | boolean | No | `false` | Editor lock flag. |
| `sealed` | boolean | No | `false` | Editor sealed flag. |
| `keepRatio` | boolean | No | `false` | Preserve ratio while resizing. |
| `persistentUuid` | string | Yes | auto-generated if missing/empty | Keep stable when editing existing instances. |
| `numberProperties` | array | Yes | empty map | Arbitrary numeric custom properties keyed by name. |
| `stringProperties` | array | Yes | empty map | Arbitrary string custom properties keyed by name. |
| `initialVariables` | array/object container | Yes | empty container | Per-instance variables initialized at startup. |
| `behaviorOverridings` | object | No | empty | Behavior property overrides for this instance. |

## Custom Property Arrays

`numberProperties` and `stringProperties` use an array of `property` entries:

```json
"numberProperties": [
  { "name": "someNumberKey", "value": 42 }
],
"stringProperties": [
  { "name": "someStringKey", "value": "abc" }
]
```

From `ai-test.json`, tilemap uses a string custom property:

```json
"stringProperties": [
  {
    "name": "tilemap",
    "value": "{\"tileWidth\":32,\"tileHeight\":32,\"dimX\":1,\"dimY\":1,\"layers\":[{\"id\":0,\"alpha\":1,\"tiles\":[[96]]}]}"
  }
]
```

## Compatibility Rules From Engine Source

- Reader accepts legacy container names:
  - `instances` or legacy `Positions`
  - array item names `instance` or legacy `Objet`
- Reader maps legacy `numberProperties` keys into native fields:
  - `z`, `rotationX`, `rotationY`, `depth`
- `depth` enables custom depth even if `customSize` is `false`.
- `defaultWidth`, `defaultHeight`, `defaultDepth` may be read if present but
  are not written during serialize.

## Editing Safety Checklist

Before saving changes:

1. Keep `name` valid for an existing object.
2. Keep `persistentUuid` unchanged for edited instances.
3. Ensure `layer` exists in `layers` (or `""` for base layer).
4. Keep `numberProperties`, `stringProperties`, and `initialVariables` present.
5. Preserve unknown custom property keys instead of deleting them.
6. Use `zOrder` for 2D ordering and `z`/`rotationX`/`rotationY` for 3D data.

Validator helper:

- Validate only:
  - `scripts/validate-instances.ps1 -ScenePath <layout.json> -ProjectPath <game.json> -Mode validate`
- Validate plus fix suggestions:
  - `scripts/validate-instances.ps1 -ScenePath <layout.json> -ProjectPath <game.json> -Mode suggest-fixes`

## Object Type Notes (Dark-Ship-Codex Scenes)

The following notes are derived from real scene instances in:

- `C:/GameDev/Dark-Ship-Codex/layouts/ai-test.json`
- `C:/GameDev/Dark-Ship-Codex/layouts/data-import.json`
- `C:/GameDev/Dark-Ship-Codex/layouts/main.json`
- `C:/GameDev/Dark-Ship-Codex/layouts/run.json`
- `C:/GameDev/Dark-Ship-Codex/layouts/turret-test.json`
- `C:/GameDev/Dark-Ship-Codex/externalLayouts/rack.json`

### Common Baseline Across Types

Most instances across these scenes include this core field set:

- `angle`, `customSize`, `height`, `layer`, `name`, `persistentUuid`, `width`,
  `x`, `y`, `zOrder`
- `numberProperties`, `stringProperties`, `initialVariables`

`keepRatio` and `depth` are common but not universal, depending on object type.

### Type-Specific Patterns

| Object Type | Observed Count | Practical Notes for Placement |
|------------|----------------|-------------------------------|
| `TextObject::Text` | 56 | Usually 2D UI labels. Commonly carries `keepRatio` and often uses `initialVariables` (`ID`, `String`, `Label` in this project). |
| `PanelSpriteButton::PanelSpriteButton` | 28 | UI buttons. Uses standard placement fields; this project frequently seeds instance variables (`ID`, `Label`, sometimes `Cost`). |
| `Sprite` | 21 | Generic world/UI sprites. In this project, some instances include `opacity`; preserve it when present. |
| `PanelSpriteObject::PanelSprite` | 8 | Panel backgrounds/containers. Typically include `depth` and sometimes per-instance IDs in `initialVariables`. |
| `BBText::BBText` | 6 | Rich text UI labels; same baseline placement fields as regular text here. |
| `SpriteToggleSwitch::SpriteToggleSwitch` | 3 | Toggle UI controls; uses standard 2D fields. |
| `PanelSpriteContinuousBar::PanelSpriteContinuousBar` | 2 | Resource bars; observed with `depth` and no `keepRatio` in this project. |
| `PanelSpriteSlider::PanelSpriteSlider` | 2 | Slider controls; observed without `depth` in these scenes. |
| `PrimitiveDrawing::Drawer` | 2 | Shape/ray debug drawers; observed without `depth` in these scenes. |
| `TextInput::TextInputObject` | 1 | Input field; observed with `depth` and standard placement keys. |

### Dark-Ship Instance Variable Pattern

In these scenes, object linking is often done through `initialVariables` on
instances:

- `ID` is the most common instance variable.
- UI-ish instances frequently include `Label`.
- Some text instances include `String`.
- A few button instances include `Cost`.

When cloning or moving these instances, preserve `initialVariables` exactly.

## Patch Recipes

Use these when manually editing `instances` safely.

### Move One Instance

Edit only position fields:

```json
{
  "name": "MenuButton",
  "x": 640,
  "y": 360
}
```

Preserve `persistentUuid`, `initialVariables`, and property arrays.

### Change Layer Safely

1. Set `layer` to an existing scene layer name.
2. Keep the same `zOrder` unless you intentionally change draw order.

```json
{
  "name": "HudPanel",
  "layer": "Results",
  "zOrder": 44
}
```

### Duplicate an Instance

1. Copy the full instance object.
2. Change `x`/`y` (and optionally `layer`, `zOrder`).
3. Generate a new `persistentUuid` for the duplicate only.
4. Keep `initialVariables`, `numberProperties`, and `stringProperties`.

### Add a New Instance From Scratch

1. Start from the minimum safe template above.
2. Set `name` to a valid object in scene or project objects.
3. Set `layer` to `""` or an existing layer.
4. Add type-specific overrides only when needed.
