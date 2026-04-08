# GDevelop Camera & Layers — Full Reference

Extracted from `CameraExtension.cpp`. Extension ID: `BuiltinCamera`.

> Most actions use `AddCodeOnlyParameter("currentScene", "")` as first internal
> parameter — do NOT include in JSON `parameters[]`.
> Layer parameters default to `""` (base layer). Camera number defaults to `0`.

---

## Table of Contents
1. [Camera Position](#camera-position)
2. [Camera Angle](#camera-angle)
3. [Camera Zoom](#camera-zoom)
4. [Camera Borders & Size](#camera-borders--size)
5. [Camera Centering](#camera-centering)
6. [Camera Boundaries (Clamping)](#camera-boundaries)
7. [Camera Management](#camera-management)
8. [Layers — Visibility](#layers--visibility)
9. [Layers — Time Scale](#layers--time-scale)
10. [Layers — Effects](#layers--effects)
11. [Layers — Z Order](#layers--z-order)
12. [Expressions](#expressions)

---

## Camera Position

### [ACTION / CONDITION / EXPRESSION] `CameraCenterX`
**Label:** Camera center X position
**Sentence:** the X position of camera _PARAM4_ (layer: _PARAM3_)
**Parameters (action):** operator, value, layer (optional, default `""`), camera number (optional, default `0`)
**Parameters (condition):** relationalOperator, value, layer, camera number

```json
{
  "type": { "value": "SetCameraCenterX" },
  "parameters": ["=", "400", "\"\"", "0"]
}
```
> Note: The action name is `SetCameraCenterX`, condition/expression is `CameraCenterX`.

### [ACTION / CONDITION / EXPRESSION] `CameraCenterY`
**Parameters:** same structure as `CameraCenterX`

---

## Camera Angle

### [ACTION / CONDITION / EXPRESSION] `CameraAngle`
**Label:** Angle of a camera of a layer
**Sentence:** the angle of camera (layer: _PARAM3_, camera: _PARAM4_)
**Parameters:** operator/relationalOp, value, layer (optional), camera number (optional)
> Action name: `SetCameraAngle`

---

## Camera Zoom

### [ACTION] `ZoomCamera`
**Sentence:** Change camera zoom to _PARAM1_ (layer: _PARAM2_, camera: _PARAM3_)
**Parameters:**
- PARAM0: (expression) Zoom value — `1`=normal, `2`=2x zoom, `0.5`=half zoom
- PARAM1: (layer) Layer — optional, default `""`
- PARAM2: (expression) Camera number — optional, default `0`

```json
{
  "type": { "value": "ZoomCamera" },
  "parameters": ["2", "\"\"", "0"]
}
```

### [CONDITION] `CameraZoom`
**Sentence:** Zoom of camera _PARAM2_ of layer _PARAM1_
**Parameters:** layer, camera number, relationalOperator, value

---

## Camera Borders & Size

### [CONDITION / EXPRESSION] `CameraWidth`
**Parameters:** layer, camera number, relationalOp, value

### [CONDITION / EXPRESSION] `CameraHeight`
**Parameters:** layer, camera number, relationalOp, value

### [CONDITION / EXPRESSION] `CameraBorderLeft`
**Parameters:** layer, camera number, relationalOp, value

### [CONDITION / EXPRESSION] `CameraBorderRight`
**Parameters:** layer, camera number, relationalOp, value

### [CONDITION / EXPRESSION] `CameraBorderTop`
**Parameters:** layer, camera number, relationalOp, value

### [CONDITION / EXPRESSION] `CameraBorderBottom`
**Parameters:** layer, camera number, relationalOp, value

### [ACTION] `CameraSize`
**Sentence:** Change the size of camera _PARAM2_ of _PARAM1_ to _PARAM3_ x _PARAM4_
**Parameters:**
- PARAM0: (layer) Layer
- PARAM1: (expression) Camera number
- PARAM2: (expression) Width
- PARAM3: (expression) Height

### [ACTION] `CameraViewport`
**Sentence:** Set the render zone of camera _PARAM2_ from layer _PARAM1_ to _PARAM3_;_PARAM4_ _PARAM5_;_PARAM6_
**Parameters:** layer, camera number, topLeftX (0–1), topLeftY (0–1), bottomRightX (0–1), bottomRightY (0–1)

---

## Camera Centering

### [ACTION] `CenterCameraOnObject`
**Sentence:** Center camera on _PARAM1_ (layer: _PARAM3_)
**Parameters:**
- PARAM0: (objectPtr) Object to center on
- PARAM1: (yesorno) Anticipate movement — default `"yes"`
- PARAM2: (layer) Layer — optional, default `""`
- PARAM3: (expression) Camera number — optional, default `0`

```json
{
  "type": { "value": "CenterCameraOnObject" },
  "parameters": ["Player", "yes", "\"\"", "0"]
}
```

---

## Camera Boundaries

### [ACTION] `ClampCamera`
**Sentence:** Enforce camera boundaries (left: _PARAM1_, top: _PARAM2_, right: _PARAM3_, bottom: _PARAM4_, layer: _PARAM5_)
**Parameters:**
- PARAM0: (expression) Left bound X
- PARAM1: (expression) Top bound Y
- PARAM2: (expression) Right bound X
- PARAM3: (expression) Bottom bound Y
- PARAM4: (layer) Layer — optional
- PARAM5: (expression) Camera number — optional

---

## Camera Management

### [ACTION] `AddCamera`
**Sentence:** Add a camera to layer _PARAM1_
**Parameters:**
- PARAM0: (layer) Layer
- PARAM1: (expression) Width — optional
- PARAM2: (expression) Height — optional
- PARAM3–6: (expression) Render zone viewport coords (0–1), optional

### [ACTION] `DeleteCamera`
**Sentence:** Delete camera _PARAM2_ from layer _PARAM1_
**Parameters:**
- PARAM0: (layer) Layer
- PARAM1: (expression) Camera number

---

## Layers — Visibility

### [ACTION] `ShowLayer`
**Sentence:** Show layer _PARAM1_
**Parameters:** PARAM0: (layer) Layer name

### [ACTION] `HideLayer`
**Sentence:** Hide layer _PARAM1_
**Parameters:** PARAM0: (layer) Layer name

### [CONDITION] `LayerVisible`
**Sentence:** Layer _PARAM1_ is visible
**Parameters:** PARAM0: (layer) Layer name

---

## Layers — Time Scale

### [ACTION] `ChangeLayerTimeScale`
**Sentence:** Set the time scale of layer _PARAM1_ to _PARAM2_
**Parameters:**
- PARAM0: (layer) Layer — optional, default `""`
- PARAM1: (expression) Scale — `1`=normal, `2`=2x faster, `0.5`=2x slower

### [CONDITION] `LayerTimeScale`
**Parameters:** layer, relationalOperator, value

### [EXPRESSION] `LayerTimeScale`
**Parameters:** layer

---

## Layers — Effects

### [ACTION] `EnableLayerEffect`
**Sentence:** Enable effect _PARAM2_ on layer _PARAM1_: _PARAM3_
**Parameters:**
- PARAM0: (layer) Layer — optional
- PARAM1: (layerEffectName) Effect name
- PARAM2: (yesorno) Enable — optional

### [CONDITION] `LayerEffectEnabled`
**Sentence:** Effect _PARAM2_ on layer _PARAM1_ is enabled
**Parameters:** layer, effectName

### [ACTION] `SetLayerEffectParameter`
**Sentence:** Set _PARAM3_ to _PARAM4_ for effect _PARAM2_ of layer _PARAM1_
**Parameters:** layer, effectName, propertyName, value (expression)

### [ACTION] `SetLayerEffectStringParameter`
**Parameters:** layer, effectName, propertyName, value (string)

### [ACTION] `SetLayerEffectBooleanParameter`
**Sentence:** Enable _PARAM3_ for effect _PARAM2_ of layer _PARAM1_: _PARAM4_
**Parameters:** layer, effectName, propertyName, (yesorno)

### [ACTION] `SetLayerAmbientLightColor`
**Sentence:** Set the ambient color of the lighting layer _PARAM1_ to _PARAM2_
**Parameters:**
- PARAM0: (layer) Layer — default `"Lighting"`
- PARAM1: (color) Color string e.g. `"255;200;200"`

---

## Layers — Z Order

### [ACTION] `SetLayerDefaultZOrder`
**Sentence:** Set the default Z order of objects created on _PARAM1_ to _PARAM2_
**Parameters:** layer, value (expression)

### [CONDITION] `LayerDefaultZOrder`
**Parameters:** layer, relationalOperator, value

### [EXPRESSION] `LayerDefaultZOrder`
**Parameters:** layer

---

## Expressions

| Expression | Description | Parameters |
|-----------|-------------|-----------|
| `CameraCenterX` | X position of camera center | layer, camera number |
| `CameraCenterY` | Y position of camera center | layer, camera number |
| `CameraAngle` | Rotation angle of camera (degrees) | layer, camera number |
| `CameraZoom` | Zoom of camera | layer, camera number |
| `CameraWidth` | Width of camera | layer, camera number |
| `CameraHeight` | Height of camera | layer, camera number |
| `CameraBorderLeft` | Left border X of camera | layer, camera number |
| `CameraBorderRight` | Right border X of camera | layer, camera number |
| `CameraBorderTop` | Top border Y of camera | layer, camera number |
| `CameraBorderBottom` | Bottom border Y of camera | layer, camera number |
| `CameraViewportLeft` | Viewport top-left X (0–1) | layer, camera number |
| `CameraViewportTop` | Viewport top-left Y (0–1) | layer, camera number |
| `CameraViewportRight` | Viewport bottom-right X (0–1) | layer, camera number |
| `CameraViewportBottom` | Viewport bottom-right Y (0–1) | layer, camera number |
| `LayerTimeScale` | Time scale of layer | layer |
| `LayerDefaultZOrder` | Default Z order for layer | layer |