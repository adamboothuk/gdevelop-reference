# GDevelop Base Object — Full Reference

Extracted from `BaseObjectExtension.cpp`. Each entry shows:
- Internal name (the `"value"` used in JSON)
- Parameter list in order (PARAM0, PARAM1, ...)
- Sentence template (shows intent and parameter slots)
- Deprecated aliases where relevant

---

## Table of Contents
1. [Timers](#timers)
2. [Position](#position)
3. [Angle / Rotation](#angle--rotation)
4. [Forces / Movement](#forces--movement)
5. [Visibility](#visibility)
6. [Layer & Z-Order](#layer--z-order)
7. [Size](#size)
8. [Variables](#variables)
9. [Variables — Arrays & Structures](#variables--arrays--structures)
10. [Behaviors](#behaviors)
11. [Collision](#collision)
12. [Effects](#effects)
13. [Objects (general)](#objects-general)
14. [Expressions](#expressions)

---

## Timers

### [CONDITION] `CompareObjectTimer` ✅ PREFERRED
**Label:** Value of an object timer
**Description:** Compare the elapsed time of an object timer. This condition doesn't start the timer.
**Sentence:** The timer _PARAM1_ of _PARAM0_ _PARAM2_ _PARAM3_ seconds
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (identifier) Timer's name — quoted string e.g. `"\"MoveTimer\""`
- PARAM2: (relationalOperator) Sign of the test — e.g. `">="`, `">"`, `"="`, `"<"`
- PARAM3: (expression) Time in seconds — e.g. `"1"`

**Example JSON:**
```json
{
  "type": { "value": "CompareObjectTimer" },
  "parameters": ["TestObject", "\"MoveTimer\"", ">=", "1"]
}
```

---

### [CONDITION] `ObjectTimer` ⚠️ DEPRECATED
**Description:** Test the elapsed time of an object timer. Replaced by `CompareObjectTimer`.
**Sentence:** The timer _PARAM1_ of _PARAM0_ is greater than _PARAM2_ seconds
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (identifier) Timer's name
- PARAM2: (expression) Time in seconds
> ⚠️ This is the older form — only checks `>`. Use `CompareObjectTimer` for full operator support.

---

### [ACTION] `ResetObjectTimer`
**Label:** Start (or reset) an object timer
**Description:** Reset the specified object timer. If it doesn't exist, it's created and started.
**Sentence:** Start (or reset) the timer _PARAM1_ of _PARAM0_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (identifier) Timer's name — quoted string e.g. `"\"MoveTimer\""`

**Example JSON:**
```json
{
  "type": { "value": "ResetObjectTimer" },
  "parameters": ["TestObject", "\"MoveTimer\""]
}
```

---

### [CONDITION] `ObjectTimerPaused`
**Sentence:** The timer _PARAM1_ of _PARAM0_ is paused
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (identifier) Timer's name

---

### [ACTION] `PauseObjectTimer`
**Sentence:** Pause timer _PARAM1_ of _PARAM0_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (identifier) Timer's name

---

### [ACTION] `UnPauseObjectTimer`
**Sentence:** Unpause timer _PARAM1_ of _PARAM0_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (identifier) Timer's name

---

### [ACTION] `RemoveObjectTimer`
**Sentence:** Delete timer _PARAM1_ of _PARAM0_ from memory
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (identifier) Timer's name

---

### [EXPRESSION] `ObjectTimerElapsedTime`
**Description:** Value of an object timer (in seconds)
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (identifier) Timer's name

**Usage in expression:** `TestObject.ObjectTimerElapsedTime("MoveTimer")`

---

## Position

### [ACTION] `SetX`
**Sentence:** the X position of _PARAM0_ (operator) value
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (operator) `"="`, `"+="`, `"-="`, etc.
- PARAM2: (expression) Value
> Deprecated alias: `MettreX`

### [ACTION] `SetY`
**Parameters:** Object, operator, value
> Deprecated alias: `MettreY`

### [ACTION] `SetXY`
**Sentence:** Change the position of _PARAM0_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (operator) X operator
- PARAM2: (expression) X value
- PARAM3: (operator) Y operator
- PARAM4: (expression) Y value

### [ACTION] `SetCenter`
**Description:** Change the position of an object using its center.
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (operator) X operator
- PARAM2: (expression) X value
- PARAM3: (operator) Y operator
- PARAM4: (expression) Y value

### [ACTION] `PutAroundPosition`
**Sentence:** Put _PARAM0_ around position (_PARAM1_;_PARAM2_), with angle _PARAM3_ and radius _PARAM4_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (expression) X position
- PARAM2: (expression) Y position
- PARAM3: (expression) Angle (degrees)
- PARAM4: (expression) Radius

### [ACTION] `PutAroundObject`
**Sentence:** Put _PARAM0_ around _PARAM1_, with angle _PARAM2_ and radius _PARAM3_
**Parameters:**
- PARAM0: (object) Object to move
- PARAM1: (objectPtr) Center object
- PARAM2: (expression) Angle (degrees)
- PARAM3: (expression) Radius

### [CONDITION] `PosX`
**Sentence:** the X position of _PARAM0_ (operator) value
**Parameters:** Object, relationalOperator, value

### [CONDITION] `PosY`
**Parameters:** Object, relationalOperator, value

---

## Angle / Rotation

### [ACTION] `SetAngle`
**Parameters:** Object, operator, angle(degrees)

### [ACTION] `Rotate`
**Sentence:** Rotate _PARAM0_ by _PARAM1_ degrees
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (expression) Angular speed (degrees/second) — used as amount if no dt applied

### [ACTION] `RotateTowardAngle`
**Sentence:** Rotate _PARAM0_ towards _PARAM1_ at speed _PARAM2_ deg/second
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (expression) Target angle (degrees)
- PARAM2: (expression) Angular speed (degrees/second). Use 0 for instant.

### [ACTION] `RotateTowardPosition`
**Sentence:** Rotate _PARAM0_ towards (_PARAM1_;_PARAM2_) at speed _PARAM3_ deg/second
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (expression) Target X
- PARAM2: (expression) Target Y
- PARAM3: (expression) Angular speed

### [CONDITION] `Angle`
**Parameters:** Object, relationalOperator, value(degrees)

### [CONDITION] `AngleOfDisplacement`
**Sentence:** Angle of displacement of _PARAM0_ is around _PARAM1_ (tolerance: _PARAM2_)
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (expression) Angle (degrees)
- PARAM2: (expression) Tolerance (degrees)

### [CONDITION] `IsTotalForceAngleAround`
**Parameters:** Object, angle, tolerance

---

## Forces / Movement

### [ACTION] `AddForceTowardPosition`
**Sentence:** Add a force to _PARAM0_ toward (_PARAM1_;_PARAM2_), speed: _PARAM3_, instant: _PARAM4_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (expression) X
- PARAM2: (expression) Y
- PARAM3: (expression) Speed (px/s)
- PARAM4: (expression) 1 = instant force, 0 = permanent

### [ACTION] `AddForceTowardObject`
**Sentence:** Move _PARAM0_ toward _PARAM1_, speed: _PARAM2_, instant: _PARAM3_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (objectPtr) Target object
- PARAM2: (expression) Speed (px/s)
- PARAM3: (expression) 1 = instant, 0 = permanent

### [ACTION] `AddForceAL`
**Description:** Add a force using angle and length.
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (expression) Angle (degrees)
- PARAM2: (expression) Length/speed
- PARAM3: (expression) 1 = instant, 0 = permanent

### [ACTION] `ClearForces`
**Sentence:** Stop _PARAM0_ (remove all forces)
**Parameters:** Object
> Deprecated alias: `Arreter`

### [CONDITION] `HasNoForces`
**Sentence:** _PARAM0_ is stopped
**Parameters:** Object

### [CONDITION] `Speed`
**Description:** Compare the overall speed (from forces) of an object.
**Parameters:** Object, relationalOperator, value

---

## Visibility

### [ACTION] `Hide`
**Sentence:** Hide _PARAM0_
**Parameters:** Object
> Deprecated alias: `Cache`

### [ACTION] `Show`
**Sentence:** Show _PARAM0_
**Parameters:** Object
> Deprecated alias: `Montre`

### [CONDITION] `Visible`
**Sentence:** _PARAM0_ is visible (not marked as hidden)
**Parameters:** Object

### [CONDITION] `Invisible`
**Sentence:** _PARAM0_ is hidden (not visible)
**Parameters:** Object

---

## Layer & Z-Order

### [ACTION] `ChangeLayer`
**Sentence:** Put _PARAM0_ on the layer _PARAM1_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (layer) Target layer name

### [ACTION] `SetZOrder`
**Parameters:** Object, operator, value
> Deprecated alias: `ChangePlan`

### [CONDITION] `Layer`
**Sentence:** _PARAM0_ is on layer _PARAM1_
**Parameters:**
- PARAM0: (object) Object
- PARAM1: (layer) Layer name

### [CONDITION] `ZOrder`
**Parameters:** Object, relationalOperator, value

---

## Size

### [EXPRESSION] `Width`
**Parameters:** Object

### [EXPRESSION] `Height`
**Parameters:** Object

---

## Variables

### [ACTION] `SetNumberObjectVariable`
**Sentence:** the variable _PARAM1_ of _PARAM0_ (operator) value
**Parameters:** Object, objectvar, operator, expression

### [ACTION] `SetStringObjectVariable`
**Parameters:** Object, objectvar, operator, string

### [ACTION] `SetBooleanObjectVariable`
**Sentence:** Change the variable _PARAM1_ of _PARAM0_: _PARAM2_
**Parameters:** Object, objectvar, true/false

### [ACTION] `ToggleObjectVariableAsBoolean`
**Parameters:** Object, objectvar

### [CONDITION] `NumberObjectVariable`
**Parameters:** Object, objectvar, relationalOperator, value

### [CONDITION] `StringObjectVariable`
**Parameters:** Object, objectvar, relationalOperator, string

### [CONDITION] `BooleanObjectVariable`
**Sentence:** The variable _PARAM1_ of _PARAM0_ is _PARAM2_
**Parameters:** Object, objectvar, true/false

### [CONDITION] `ObjectVariableChildExists`
**Parameters:** Object, objectvar(structure), childName(string)

### [EXPRESSION] `Variable`
**Parameters:** Object, objectvar

### [STR_EXPRESSION] `VariableString`
**Parameters:** Object, objectvar

---

## Variables — Arrays & Structures

### [ACTION] `ObjectVariableRemoveChild`
**Sentence:** Remove child _PARAM2_ from variable _PARAM1_ of _PARAM0_
**Parameters:** Object, structureVar, childName(string)

### [ACTION] `ObjectVariableClearChildren`
**Parameters:** Object, objectvar

### [ACTION] `PushNumberToObjectVariable`
**Sentence:** Add value _PARAM2_ to array variable _PARAM1_ of _PARAM0_
**Parameters:** Object, arrayVar, expression

### [ACTION] `PushStringToObjectVariable`
**Parameters:** Object, arrayVar, string

### [ACTION] `PushBooleanToObjectVariable`
**Parameters:** Object, arrayVar, true/false

### [ACTION] `ObjectVariablePush` / `ObjectVariablePush2`
**Description:** Add an existing variable to end of array.
**Parameters:** Object, arrayVar, sourceVar

### [CONDITION] `ObjectVariableChildCount`
**Parameters:** Object, objectvar, relationalOperator, value

### [EXPRESSION] `VariableChildCount`
**Parameters:** Object, objectvar

---

## Behaviors

### [CONDITION] `BehaviorActivated`
**Sentence:** Behavior _PARAM1_ of _PARAM0_ is activated
**Parameters:** Object, behaviorName

### [ACTION] `ActivateBehavior`
**Sentence:** Activate behavior _PARAM1_ of _PARAM0_: _PARAM2_
**Parameters:** Object, behaviorName, true/false

---

## Collision

### [CONDITION] `CollisionPoint`
**Sentence:** (_PARAM1_;_PARAM2_) is inside _PARAM0_
**Parameters:** Object, x(expression), y(expression)

### [ACTION] `SetIncludedInParentCollisionMask`
**Sentence:** Include _PARAM0_ in parent object collision mask: _PARAM1_
**Parameters:** Object, true/false

---

## Effects

### [ACTION] `EnableEffect`
**Sentence:** Enable effect _PARAM1_ on _PARAM0_: _PARAM2_
**Parameters:** Object, effectName, true/false

### [ACTION] `SetEffectDoubleParameter`
**Sentence:** Set the effect property (number) _PARAM2_ of _PARAM1_ on _PARAM0_ to _PARAM3_
**Parameters:** Object, effectName, propertyName, value(expression)

### [ACTION] `SetEffectStringParameter`
**Parameters:** Object, effectName, propertyName, string

### [ACTION] `SetEffectBooleanParameter`
**Parameters:** Object, effectName, propertyName, true/false

### [CONDITION] `IsEffectEnabled`
**Sentence:** Effect _PARAM1_ of _PARAM0_ is enabled
**Parameters:** Object, effectName

---

## Objects (general)

### [ACTION] `Delete`
**Sentence:** Delete _PARAM0_
**Parameters:** Object

### [STR_EXPRESSION] `ObjectName`
**Returns:** Name of the object as a string
**Parameters:** Object

### [STR_EXPRESSION] `Layer`
**Returns:** Name of the layer the object is on
**Parameters:** Object

---

## Expressions (numeric unless noted)

| Expression | Description | Parameters |
|-----------|-------------|-----------|
| `X` | X position | Object |
| `Y` | Y position | Object |
| `Angle` | Current angle in degrees | Object |
| `Width` | Width | Object |
| `Height` | Height | Object |
| `ZOrder` | Z-order | Object |
| `ForceX` | X component of sum of forces | Object |
| `ForceY` | Y component of sum of forces | Object |
| `ForceAngle` | Angle of sum of forces (degrees) | Object |
| `ForceLength` | Length of sum of forces | Object |
| `Distance` | Distance to another object | Object, targetObject |
| `SqDistance` | Square distance to another object | Object, targetObject |
| `DistanceToPosition` | Distance to a position | Object, x, y |
| `SqDistanceToPosition` | Square distance to a position | Object, x, y |
| `Variable` | Number value of a variable | Object, varName |
| `VariableString` *(str)* | Text value of a variable | Object, varName |
| `VariableChildCount` | Number of children in array/structure | Object, varName |
| `ObjectTimerElapsedTime` | Elapsed time of an object timer (seconds) | Object, timerName |
| `ObjectName` *(str)* | Name of the object | Object |

---

## Operator Reference

**Action operators (modify value):**
- `"="` — set
- `"+="` — add
- `"-="` — subtract
- `"*="` — multiply
- `"/="` — divide

**Condition operators (compare value):**
- `"="` — equal
- `"!="` — not equal
- `">"` — greater than
- `">="` — greater than or equal
- `"<"` — less than
- `"<="` — less than or equal