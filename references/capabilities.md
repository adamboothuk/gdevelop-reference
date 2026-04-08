# GDevelop Capabilities — Full Reference

Covers six capability extensions extracted from source. All use scoped naming
(`Prefix::ActionName`) and require the matching behavior as PARAM1.

Behavior name strings to use in JSON parameters:
- Text content → `"Text"`
- Scale → `"Scale"`
- Resize → `"Resizable"`
- Opacity → `"Opacity"`
- Flip → `"Flippable"`
- Effects → `"Effect"`

---

## Table of Contents
1. [TextContainer — text content](#textcontainer)
2. [Scalable — scale](#scalable)
3. [Resizable — width/height](#resizable)
4. [Opacity — transparency](#opacity)
5. [Flippable — flip](#flippable)
6. [Effect — visual effects](#effect)

---

## TextContainer

**Capability:** `TextContainerCapability`
**Behavior:** `"Text"`

### [ACTION / CONDITION / STR_EXPRESSION] `Text::Value`
**Label:** Text
**Description:** The text content of the object.
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Text"`
- PARAM2: (operator/relationalOperator) for action/condition
- PARAM3: (string) Text value

**Action example:**
```json
{
  "type": { "value": "Text::Value" },
  "parameters": ["MyTextObject", "Text", "=", "\"Hello world\""]
}
```

---

## Scalable

**Capability:** `ScalableCapability`
**Behavior:** `"Scale"`
Default scale is 1. Values >1 enlarge, <1 shrink.

### [ACTION / CONDITION / EXPRESSION] `Scale::Value`
**Label:** Scale (uniform)
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Scale"`
- PARAM2: (operator/relationalOperator)
- PARAM3: (number) Scale value (default 1)

### [ACTION / CONDITION / EXPRESSION] `Scale::X`
**Label:** Scale on X axis
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Scale"`
- PARAM2: (operator/relationalOperator)
- PARAM3: (number) Scale value

### [ACTION / CONDITION / EXPRESSION] `Scale::Y`
**Label:** Scale on Y axis
**Parameters:** same as `Scale::X`

**Action example:**
```json
{
  "type": { "value": "Scale::X" },
  "parameters": ["MySprite", "Scale", "=", "2"]
}
```

---

## Resizable

**Capability:** `ResizableCapability`
**Behavior:** `"Resizable"`
Sets absolute pixel dimensions, unlike Scale which uses a multiplier.

### [ACTION] `Resizable::SetWidth`
**Label:** Width
**Sentence:** the width of _PARAM0_ (operator) value
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Resizable"`
- PARAM2: (operator) e.g. `"="`
- PARAM3: (number) Width in pixels

### [CONDITION] `Resizable::Width`
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Resizable"`
- PARAM2: (relationalOperator)
- PARAM3: (number) Width in pixels

### [ACTION] `Resizable::SetHeight`
**Parameters:** same structure as `Resizable::SetWidth`

### [CONDITION] `Resizable::Height`
**Parameters:** same structure as `Resizable::Width`

### [ACTION] `Resizable::SetSize`
**Label:** Size (set both dimensions at once)
**Sentence:** Change the size of _PARAM0_: set to _PARAM2_ x _PARAM3_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Resizable"`
- PARAM2: (expression) Width
- PARAM3: (expression) Height

```json
{
  "type": { "value": "Resizable::SetSize" },
  "parameters": ["MyObject", "Resizable", "200", "100"]
}
```

---

## Opacity

**Capability:** `OpacityCapability`
**Behavior:** `"Opacity"`
Range: 0 (fully transparent) to 255 (fully opaque).

### [ACTION / CONDITION / EXPRESSION] `Opacity::Value`
**Label:** Opacity
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Opacity"`
- PARAM2: (operator/relationalOperator)
- PARAM3: (number) Opacity 0–255

**Action example:**
```json
{
  "type": { "value": "Opacity::Value" },
  "parameters": ["MySprite", "Opacity", "=", "128"]
}
```

---

## Flippable

**Capability:** `FlippableCapability`
**Behavior:** `"Flippable"`

### [ACTION] `Flippable::FlipX`
**Label:** Flip the object horizontally
**Sentence:** Flip horizontally _PARAM0_: _PARAM2_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Flippable"`
- PARAM2: (yesorno) `"yes"` to flip, `"no"` to unflip

```json
{
  "type": { "value": "Flippable::FlipX" },
  "parameters": ["MySprite", "Flippable", "yes"]
}
```

### [ACTION] `Flippable::FlipY`
**Label:** Flip the object vertically
**Parameters:** same as `Flippable::FlipX`

### [CONDITION] `Flippable::FlippedX`
**Sentence:** _PARAM0_ is horizontally flipped
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Flippable"`

### [CONDITION] `Flippable::FlippedY`
**Sentence:** _PARAM0_ is vertically flipped
**Parameters:** same as `Flippable::FlippedX`

---

## Effect

**Capability:** `EffectCapability`
**Behavior:** `"Effect"`

### [ACTION] `Effect::EnableEffect`
**Sentence:** Enable effect _PARAM2_ on _PARAM0_: _PARAM3_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Effect"`
- PARAM2: (objectEffectName) Effect name
- PARAM3: (yesorno) `"yes"` to enable, `"no"` to disable

### [ACTION] `Effect::SetEffectDoubleParameter`
**Label:** Effect property (number)
**Sentence:** Set _PARAM3_ to _PARAM4_ for effect _PARAM2_ of _PARAM0_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Effect"`
- PARAM2: (objectEffectName) Effect name
- PARAM3: (objectEffectParameterName) Property name
- PARAM4: (expression) New value

### [ACTION] `Effect::SetEffectStringParameter`
**Label:** Effect property (string)
**Sentence:** Set _PARAM3_ to _PARAM4_ for effect _PARAM2_ of _PARAM0_
**Parameters:**
- PARAM0–PARAM3: same as `SetEffectDoubleParameter`
- PARAM4: (string) New string value

### [ACTION] `Effect::SetEffectBooleanParameter`
**Label:** Effect property (enable or disable)
**Sentence:** Enable _PARAM3_ for effect _PARAM2_ of _PARAM0_: _PARAM4_
**Parameters:**
- PARAM0–PARAM3: same as `SetEffectDoubleParameter`
- PARAM4: (yesorno) Enable this property

### [CONDITION] `Effect::IsEffectEnabled`
**Sentence:** Effect _PARAM2_ of _PARAM0_ is enabled
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (behavior) `"Effect"`
- PARAM2: (objectEffectName) Effect name