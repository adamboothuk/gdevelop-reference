# GDevelop AnimatableCapability — Full Reference

Extracted from `AnimatableExtension.cpp`.
Behavior type: `AnimatableCapability::AnimatableBehavior`

All entries require the object as PARAM0 and the behavior as PARAM1.
In JSON, PARAM1 is the behavior name string, e.g. `"Animation"`.

> `AddExpressionAndConditionAndAction` entries generate a matching ACTION,
> CONDITION, and EXPRESSION all sharing the same internal name.

---

## Animation Selection

### [ACTION / CONDITION / EXPRESSION] `Animation::Index`
**Label:** Animation (by number)
**Description:** The animation played by the object, using the animation number (index).
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) Behavior — `"Animation"`
- PARAM2: (operator/relationalOperator) `"="` etc. for action/condition
- PARAM3: (number) Animation index

**Action example:**
```json
{
  "type": { "value": "Animation::Index" },
  "parameters": ["MySprite", "Animation", "=", "2"]
}
```

---

### [ACTION / CONDITION / STR_EXPRESSION] `Animation::Name`
**Label:** Animation (by name)
**Description:** The animation played by the object, using the animation name.
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) Behavior — `"Animation"`
- PARAM2: (operator/relationalOperator) for action/condition
- PARAM3: (objectAnimationName) Animation name string e.g. `"\"Run\""`

**Action example:**
```json
{
  "type": { "value": "Animation::Name" },
  "parameters": ["MySprite", "Animation", "=", "\"Run\""]
}
```

---

## Playback Control

### [ACTION] `Animation::PauseAnimation`
**Label:** Pause the animation
**Sentence:** Pause the animation of _PARAM0_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) Behavior — `"Animation"`

```json
{
  "type": { "value": "Animation::PauseAnimation" },
  "parameters": ["MySprite", "Animation"]
}
```

---

### [ACTION] `Animation::PlayAnimation`
**Label:** Resume the animation
**Sentence:** Resume the animation of _PARAM0_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) Behavior — `"Animation"`

---

### [ACTION / CONDITION / EXPRESSION] `Animation::SpeedScale`
**Label:** Animation speed scale
**Description:** The animation speed scale (1 = default, >1 = faster, <1 = slower).
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) Behavior — `"Animation"`
- PARAM2: (operator/relationalOperator) for action/condition
- PARAM3: (number) Speed scale value

---

## State Checks

### [CONDITION] `Animation::IsAnimationPaused`
**Label:** Animation paused
**Sentence:** The animation of _PARAM0_ is paused
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) Behavior — `"Animation"`

---

### [CONDITION] `Animation::HasAnimationEnded`
**Label:** Animation finished
**Sentence:** The animation of _PARAM0_ is finished
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) Behavior — `"Animation"`

---

## Timing

### [ACTION / CONDITION / EXPRESSION] `Animation::ElapsedTime`
**Label:** Animation elapsed time
**Description:** The elapsed time from the beginning of the animation (in seconds).
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) Behavior — `"Animation"`
- PARAM2: (operator/relationalOperator) for action/condition
- PARAM3: (number) Time in seconds

---

### [EXPRESSION] `Animation::Duration`
**Label:** Animation duration
**Description:** Returns the current animation duration (in seconds).
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) Behavior — `"Animation"`

---

## Scoped Naming Note

All entries from this extension use the `Animation::` prefix (scoped actions).
In JSON the `"value"` must include this prefix, e.g. `"Animation::PauseAnimation"`,
not just `"PauseAnimation"`.