---
name: gdevelop-reference
description: >
  GDevelop game engine reference for actions, conditions, expressions,
  object-definition JSON, and scene instance JSON.
  Use this skill whenever the user is working with GDevelop scene JSON files,
  asking about GDevelop event syntax, looking up the correct internal name for
  an action/condition/expression, asking how to structure parameters in a
  GDevelop event, creating or editing object definitions in project/scene
  `objects` arrays, editing object placement in a scene `instances` array, or
  debugging GDevelop JSON. This skill prevents guessing at internal identifiers
  and instance schema fields - always consult it before writing any GDevelop
  event or instance JSON. Trigger on any mention of GDevelop, .json scene
  files, actions, conditions, events, objects, instances, timers, variables,
  forces, or layers in a GDevelop context.
---

# GDevelop Reference Skill

This skill provides authoritative reference data for GDevelop's built-in
object actions, conditions, expressions, project/scene object definitions, and
scene/external-layout instance JSON, extracted from GDevelop source and
verified project captures.

## Critical Rule

Never guess an internal identifier, object-definition field, or scene instance
field.
If a needed action, condition, expression, object attribute, or instance
attribute is not listed
in this skill or its reference files, say so explicitly and ask the user to
provide a verified example from GDevelop's editor or source.

## How To Use This Skill

When writing or editing GDevelop JSON:

1. Decide whether the task is `events`, `objects`, or `instances` work.
2. For events: identify the event family first, then look up exact instruction
   identifiers and parameter order.
3. For object definitions: open `references/objects.md` first and validate
   type templates, baseline fields, and resource dependencies before editing
   `objects` entries.
4. For behavior attachment: open `references/behaviors.md` when adding/removing
   object behaviors or scene `behaviorsSharedData`.
5. For instances: open `references/instances.md` first and validate field names,
   defaults, and optional attributes before editing placement data.
6. Never drop required fields (`name`, `x`, `y`, `zOrder`, `layer`, `angle`,
   `customSize`, `width`, `height`, `persistentUuid`) when writing instances.
7. For manual scene edits, run `scripts/validate-instances.ps1` before
   finalizing.
8. For relational event conditions, include the operator (`>=`, `=`, `<`,
   etc.) as a parameter.
9. If the task is niche or category-specific, open only the matching file under
   `references/`.

## JSON Event Structure

```json
{
  "type": "BuiltinCommonInstructions::Standard",
  "conditions": [
    {
      "type": { "value": "CONDITION_NAME" },
      "parameters": ["ObjectName", "\"timerName\"", ">=", "1"]
    }
  ],
  "actions": [
    {
      "type": { "value": "ACTION_NAME" },
      "parameters": ["ObjectName", "=", "expression"]
    }
  ]
}
```

Key formatting rules:

- Object names: plain string, for example `"Player"`
- Timer and identifier names: quoted string inside the JSON string, for example `"\"MoveTimer\""`
- Action operators: `"="`, `"+="`, `"-="`, `"*="`, `"/="`
- Condition operators: `"="`, `"!="`, `">"`, `">="`, `"<"`, `"<="`
- Expressions: plain string, for example `"RandomInRange(0, 800)"`

## Quick Reference By Category

Use this section as a fast lookup index. Open the linked reference file when the
task needs full parameter detail, sentence templates, deprecated mappings, or
examples.

### Base Object

Open `references/base-object.md` for full details.

Timers:

| Type | Internal Name | Parameters |
|------|---------------|------------|
| ACTION | `ResetObjectTimer` | Object, "timerName" |
| CONDITION | `CompareObjectTimer` | Object, "timerName", operator, seconds |
| CONDITION | `ObjectTimerPaused` | Object, "timerName" |
| ACTION | `PauseObjectTimer` | Object, "timerName" |
| ACTION | `UnPauseObjectTimer` | Object, "timerName" |
| ACTION | `RemoveObjectTimer` | Object, "timerName" |
| EXPRESSION | `ObjectTimerElapsedTime` | Object, "timerName" |

Note: `ObjectTimer` is deprecated. Use `CompareObjectTimer` instead.

Position:

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `SetX` | Object, operator, value |
| ACTION | `SetY` | Object, operator, value |
| ACTION | `SetXY` | Object, operator, x, operator, y |
| CONDITION | `PosX` | Object, operator, value |
| CONDITION | `PosY` | Object, operator, value |
| EXPRESSION | `X` | Object |
| EXPRESSION | `Y` | Object |

Visibility:

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `Hide` | Object |
| ACTION | `Show` | Object |
| CONDITION | `Visible` | Object |

Forces and movement:

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `ClearForces` | Object |
| ACTION | `AddForceTowardPosition` | Object, x, y, speed, instant(0/1) |
| ACTION | `AddForceTowardObject` | Object, targetObject, speed, instant(0/1) |
| CONDITION | `HasNoForces` | Object |
| CONDITION | `Speed` | Object, operator, value |
| EXPRESSION | `ForceX` | Object |
| EXPRESSION | `ForceY` | Object |
| EXPRESSION | `ForceAngle` | Object |
| EXPRESSION | `ForceLength` | Object |

Layer and z-order:

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `ChangeLayer` | Object, "LayerName" |
| ACTION | `SetZOrder` | Object, operator, value |
| CONDITION | `Layer` | Object, "LayerName" |
| CONDITION | `ZOrder` | Object, operator, value |
| EXPRESSION | `ZOrder` | Object |
| STR_EXPRESSION | `Layer` | Object |

Variables:

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `SetNumberObjectVariable` | Object, varName, operator, value |
| ACTION | `SetStringObjectVariable` | Object, varName, operator, value |
| ACTION | `SetBooleanObjectVariable` | Object, varName, operator, true/false |
| CONDITION | `NumberObjectVariable` | Object, varName, operator, value |
| CONDITION | `StringObjectVariable` | Object, varName, operator, value |
| CONDITION | `BooleanObjectVariable` | Object, varName, true/false |
| EXPRESSION | `Variable` | Object, varName |
| STR_EXPRESSION | `VariableString` | Object, varName |

Behaviors:

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `ActivateBehavior` | Object, behaviorName, true/false |
| CONDITION | `BehaviorActivated` | Object, behaviorName |

Collision and objects:

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `CollisionPoint` | Object, x, y |
| ACTION | `Delete` | Object |
| STR_EXPRESSION | `ObjectName` | Object |

Distance expressions:

| Type | Name | Parameters |
|------|------|------------|
| EXPRESSION | `Distance` | Object, targetObject |
| EXPRESSION | `SqDistance` | Object, targetObject |
| EXPRESSION | `DistanceToPosition` | Object, x, y |
| EXPRESSION | `SqDistanceToPosition` | Object, x, y |

### Scene Instances

Open `references/instances.md` when the task touches:

- placing objects directly in a scene JSON `instances` array
- editing external layout `instances`
- custom per-instance properties (`numberProperties`, `stringProperties`)
- per-instance variable initialization (`initialVariables`)
- preserving/repairing `persistentUuid` values
- 2D/3D placement fields (`x`, `y`, `z`, `zOrder`, `rotationX`, `rotationY`)
- object-type-specific placement notes from real project scenes
- safe patch workflows for move/layer/duplicate/new-instance edits

Validation helper:

- `scripts/validate-instances.ps1 -ScenePath <layout.json> [-ProjectPath <game.json>] [-Mode validate|suggest-fixes]`

### Scene And Project Objects

Open `references/objects.md` when the task touches:

- creating a new object definition in `game.json` (`objects`)
- creating or editing scene-local object definitions in `layouts/<scene>.json` (`objects`)
- choosing scope: scene-local by default vs global only for deliberate cross-scene reuse
- selecting a baseline object template by `type` (for example `Sprite`, `TextObject::Text`)
- wiring object resources (image/font names used by object content)
- object-level defaults and safe fields to preserve (`variables`, `effects`, `behaviors`)

Open `references/behaviors.md` when the task touches:

- adding or removing object behaviors in JSON
- updating scene `behaviorsSharedData`
- behavior type lookup for JSON (`type` values like `Tween::TweenBehavior`)
- compatibility checks (`Incompatible with object`) and caution tags (`Experimental`, `Deprecated`)

### Capabilities

Capability extensions use behavior-scoped naming. The JSON `"value"` must include
the capability prefix, for example `Animation::PauseAnimation`. PARAM1 is the
behavior name string.

| Capability | Behavior String | Reference |
|------------|-----------------|-----------|
| Animatable | `"Animation"` | `references/animatable.md` |
| TextContainer | `"Text"` | `references/capabilities.md` |
| Scalable | `"Scale"` | `references/capabilities.md` |
| Resizable | `"Resizable"` | `references/capabilities.md` |
| Opacity | `"Opacity"` | `references/capabilities.md` |
| Flippable | `"Flippable"` | `references/capabilities.md` |
| Effect | `"Effect"` | `references/capabilities.md` |

Common capability entries:

| Type | Name | Parameters |
|------|------|------------|
| ACTION or CONDITION or EXPR | `Animation::Index` | Object, "Animation", operator, index |
| ACTION or CONDITION or STR_EXPR | `Animation::Name` | Object, "Animation", operator, "animName" |
| ACTION | `Animation::PauseAnimation` | Object, "Animation" |
| ACTION | `Animation::PlayAnimation` | Object, "Animation" |
| CONDITION | `Animation::IsAnimationPaused` | Object, "Animation" |
| CONDITION | `Animation::HasAnimationEnded` | Object, "Animation" |
| ACTION or CONDITION or STR_EXPR | `Text::Value` | Object, "Text", operator, "string" |
| ACTION or CONDITION or EXPR | `Scale::Value` | Object, "Scale", operator, value |
| ACTION | `Resizable::SetWidth` | Object, "Resizable", operator, pixels |
| ACTION | `Resizable::SetHeight` | Object, "Resizable", operator, pixels |
| ACTION or CONDITION or EXPR | `Opacity::Value` | Object, "Opacity", operator, 0-255 |
| ACTION | `Flippable::FlipX` | Object, "Flippable", yes/no |
| ACTION | `Flippable::FlipY` | Object, "Flippable", yes/no |
| ACTION | `Effect::EnableEffect` | Object, "Effect", effectName, yes/no |

### Sprite Object

Open `references/sprite.md` for full details and deprecated mappings.

Most historical sprite-specific actions for opacity, flip, scale, and animation
are deprecated. Prefer the capability equivalents above.

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `Collision` | SpriteObject1, SpriteObject2 |
| ACTION | `ChangeColor` | Object, "R;G;B" |
| ACTION | `ChangeBlendMode` | Object, mode (0=Normal 1=Add 2=Multiply 3=Screen) |
| CONDITION | `BlendMode` | Object, operator, mode |
| EXPRESSION | `PointX` | Object, "pointName" |
| EXPRESSION | `PointY` | Object, "pointName" |
| EXPRESSION | `Sprite` | Object |
| EXPRESSION | `AnimationFrameCount` | Object |

### Audio

Open `references/audio.md` only when the task touches:

- sound or music playback
- channels
- volume or pitch
- fades or playback offsets
- preloading audio assets
- `BuiltinAudio` actions, conditions, or expressions

### Mouse And Touch

Open `references/mouse-touch.md` only when the task touches:

- cursor position
- mouse buttons
- mouse wheel
- touch input or multitouch
- touch-to-mouse simulation
- `BuiltinMouse` actions, conditions, or expressions

### Keyboard

Open `references/keyboard.md` only when the task touches:

- keyboard key checks
- key just pressed or key released logic
- the last pressed key expression
- `BuiltinKeyboard` conditions or expressions

### Camera And Layers

Open `references/camera.md` only when the task touches:

- camera center or angle
- zoom
- clamping or bounds
- viewport size or position
- layer visibility
- layer time scale
- layer effects
- ambient light
- `BuiltinCamera` actions, conditions, or expressions

### Storage

Open `references/storage.md` only when the task touches:

- persistent save data
- reading or writing stored values
- storage group paths
- preloading or unloading a storage
- `BuiltinFile` actions or conditions

### Text Manipulation

Open `references/text-manipulation.md` only when the task touches:

- built-in string functions
- uppercase or lowercase conversion
- substring, find, replace, or repeat operations
- `BuiltinStringInstructions` expressions

### Mathematical Tools

Open `references/mathematical-tools.md` only when the task touches:

- random expressions
- clamp, normalize, interpolation, or distance helpers
- trigonometry, logarithms, roots, or rounding
- `BuiltinMathematicalTools` expressions

### Scene

Open `references/scene.md` only when the task touches:

- changing scenes
- pausing or resuming scene stacks
- preloading scene assets
- background color or quitting the game
- `BuiltinScene` actions, conditions, or expressions

### Network

Open `references/network.md` only when the task touches:

- HTTP requests
- API communication
- opening URLs
- downloading files
- analytics metrics
- `BuiltinNetwork` actions

### Window And Resolution

Open `references/window.md` only when the task touches:

- fullscreen
- window title or icon
- game window size or margins
- game resolution or adaptive resize mode
- screen or window dimension expressions

### Variables

Open `references/variables.md` only when the task touches:

- generic variables
- variable comparison or assignment
- array or structure children
- JSON that uses `BuiltinVariables`
- hidden legacy scene/global variable instructions

### Time

Open `references/time.md` only when the task touches:

- scene timers
- time scale
- wait/delay actions
- delta time or timestamp expressions
- `BuiltinTime` actions, conditions, or expressions

### Scene Logic, Conversions, And External Layouts

Open `references/scene-logic.md` for full details.

Event types:

| Event Type | Description |
|------------|-------------|
| `BuiltinCommonInstructions::Standard` | Standard event |
| `BuiltinCommonInstructions::Else` | Runs if previous events were false |
| `BuiltinCommonInstructions::While` | Repeat while conditions are true |
| `BuiltinCommonInstructions::Repeat` | Repeat N times using `repeatExpression` |
| `BuiltinCommonInstructions::ForEach` | Repeat per object instance |
| `BuiltinCommonInstructions::ForEachChildVariable` | Repeat per array or structure child |
| `BuiltinCommonInstructions::Group` | Organizational group |
| `BuiltinCommonInstructions::Link` | Link to external events |

Common scene logic entries:

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `BuiltinCommonInstructions::Once` | none |
| CONDITION | `BuiltinCommonInstructions::CompareNumbers` | expr, relOp, expr |
| CONDITION | `BuiltinCommonInstructions::CompareStrings` | string, relOp, string |
| EXPRESSION | `ToNumber` | string |
| STR_EXPR | `ToString` | expression |
| STR_EXPR | `LargeNumberToString` | expression |
| EXPRESSION | `ToRad` | angle |
| EXPRESSION | `ToDeg` | angle |
| STR_EXPR | `ToJSON` | variable |
| STR_EXPR | `ObjectVarToJSON` | object, objectvar |
| ACTION | `JSONToVariableStructure2` | jsonString, variable |
| ACTION | `JSONToObjectVariableStructure` | jsonString, object, objectvar |
| ACTION | `CreateObjectsFromExternalLayout` | layoutName, x, y, z |

## Reference Routing Table

Use this table to decide which file to open next.

| Need | File |
|------|------|
| Project/scene `objects` schema, type templates, and resource-linking rules | `references/objects.md` |
| Object behavior attachment, type identifiers, compatibility/caution tagging | `references/behaviors.md` |
| Scene or external layout `instances` schema, required fields, defaults, compatibility notes | `references/instances.md` |
| Base object actions, timers, variables, deprecated aliases | `references/base-object.md` |
| Animation capability details and examples | `references/animatable.md` |
| Text, scale, resize, opacity, flip, and effect capabilities | `references/capabilities.md` |
| Sprite entries, point expressions, deprecated sprite mappings | `references/sprite.md` |
| Audio playback, channels, fades, offsets, pitch, volume | `references/audio.md` |
| Mouse cursor, mouse buttons, wheel, touch, multitouch | `references/mouse-touch.md` |
| Keyboard key conditions and last pressed key | `references/keyboard.md` |
| Camera movement, zoom, viewport, layers, ambient light | `references/camera.md` |
| Persistent storage read/write, group paths, preload/unload | `references/storage.md` |
| String functions: case, substrings, find, replace, repeat | `references/text-manipulation.md` |
| Math expression names, trig, random, rounding, interpolation | `references/mathematical-tools.md` |
| Scene switching, preload progress, start/resume checks | `references/scene.md` |
| HTTP requests, URL opening, file download, analytics metrics | `references/network.md` |
| Fullscreen, window title, resolution, screen dimensions | `references/window.md` |
| Generic variables, arrays, structures, legacy scene/global forms | `references/variables.md` |
| Scene timers, time scale, wait action, time expressions | `references/time.md` |
| Event types, control flow, conversions, external layouts | `references/scene-logic.md` |
| Extension-specific instructions (for example Sticker, Smooth camera, ArrayTools) | `references/extensions/README.md` |

## Extension Coverage Notes

Extension references are maintained incrementally under `references/extensions/`.

If an extension entry does not exist yet:

1. Say coverage is missing.
2. Ask for a verified editor/source example.
3. Track the extension in `docs/extension-targets.md` before adding docs.

## Maintenance Guidance

Keep this file as the hub document. Add only:

- trigger and usage guidance
- shared JSON rules
- short fast-path indexes
- routing instructions for deciding which reference file to open

Move large catalogs, sentence templates, edge cases, deprecated mappings, and
category-specific examples into `references/`.
