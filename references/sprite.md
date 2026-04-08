# GDevelop Sprite — Full Reference

Extracted from `SpriteExtension.cpp`.
Object type: `Sprite`

The Sprite object has these capability behaviors attached by default — use their
scoped actions rather than any deprecated Sprite-specific equivalents:
- `EffectCapability::EffectBehavior` → `Effect::*`
- `ResizableCapability::ResizableBehavior` → `Resizable::*`
- `ScalableCapability::ScalableBehavior` → `Scale::*`
- `FlippableCapability::FlippableBehavior` → `Flippable::*`
- `OpacityCapability::OpacityBehavior` → `Opacity::*`
- `AnimatableCapability::AnimatableBehavior` → `Animation::*`

See `references/capabilities.md` and `references/animatable.md` for those entries.
The entries below are the Sprite-specific active (non-deprecated) items only.

---

## Collision

### [CONDITION] `Collision`
**Label:** Collision (Pixel perfect)
**Description:** True if there is a pixel-perfect collision between two Sprite objects.
**Sentence:** _PARAM0_ is in collision with _PARAM1_ (pixel perfect)
**Parameters:**
- PARAM0: (objectList) Object 1 — must be Sprite type
- PARAM1: (objectList) Object 2 — must be Sprite type

> This is defined on `extension`, not `obj` — it takes two object lists,
> not a single object + behavior. Both must be Sprite objects.

```json
{
  "type": { "value": "Collision" },
  "parameters": ["SpriteA", "SpriteB"]
}
```

---

## Effects / Appearance

### [ACTION] `ChangeColor`
**Label:** Tint color
**Description:** Change the tint of a Sprite object. Default is white (no tint).
**Sentence:** Change tint of _PARAM0_ to _PARAM1_
**Parameters:**
- PARAM0: (object) Object — Sprite
- PARAM1: (color) Tint — color string e.g. `"255;128;0"`

```json
{
  "type": { "value": "ChangeColor" },
  "parameters": ["MySprite", "255;0;0"]
}
```

---

### [ACTION] `ChangeBlendMode`
**Label:** Blend mode
**Description:** Change the blend mode of a Sprite. Default is 0 (Normal).
**Sentence:** Change Blend mode of _PARAM0_ to _PARAM1_
**Parameters:**
- PARAM0: (object) Object — Sprite
- PARAM1: (expression) Mode number: `0`=Normal, `1`=Add, `2`=Multiply, `3`=Screen

---

### [CONDITION] `BlendMode`
**Label:** Blend mode
**Description:** Compare the blend mode number currently used by an object.
**Parameters:**
- PARAM0: (object) Object — Sprite
- PARAM1: (relationalOperator)
- PARAM2: (expression) Mode number to compare

---

## Points

Sprite objects can have named points defined in the animation editor.
`PointX`/`PointY` return the scene coordinates of those points.

### [EXPRESSION] `PointX`
**Description:** X position of a named point on the Sprite.
**Parameters:**
- PARAM0: (object) Object — Sprite
- PARAM1: (objectPointName) Name of the point e.g. `"\"Tip\""`

```json
"TestObject.PointX(\"Tip\")"
```

### [EXPRESSION] `PointY`
**Description:** Y position of a named point on the Sprite.
**Parameters:**
- PARAM0: (object) Object — Sprite
- PARAM1: (objectPointName) Name of the point

---

## Animation Expressions

These are Sprite-specific expressions that complement the `Animation::*` capability actions.

### [EXPRESSION] `Sprite`
**Label:** Image (current frame index)
**Description:** Current frame number of the animation.
**Parameters:**
- PARAM0: (object) Object — Sprite

### [EXPRESSION] `AnimationFrameCount`
**Label:** Number of frames
**Description:** Number of frames in the current animation.
**Parameters:**
- PARAM0: (object) Object — Sprite

---

## Deprecated — Do Not Use

The following are hidden/deprecated and should be replaced with capability equivalents:

| Deprecated | Use instead |
|-----------|-------------|
| `Opacity` action/condition/expression | `Opacity::Value` |
| `FlipX` / `FlipY` actions | `Flippable::FlipX` / `Flippable::FlipY` |
| `FlippedX` / `FlippedY` conditions | `Flippable::FlippedX` / `Flippable::FlippedY` |
| `ScaleWidth` / `ScaleHeight` conditions | `Scale::X` / `Scale::Y` conditions |
| `Animation` / `Anim` expressions | `Animation::Index` expression |
| `AnimationName` str expression | `Animation::Name` str expression |
| `AnimationSpeedScale` expression | `Animation::SpeedScale` expression |
| `ScaleX` / `ScaleY` expressions | `Scale::X` / `Scale::Y` expressions |
| All animation set/check actions | `Animation::*` capability actions |