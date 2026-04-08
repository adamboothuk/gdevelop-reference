# GDevelop Scene Logic & Utilities — Full Reference

Covers three extensions:
- `CommonInstructionsExtension.cpp` — event types and control flow conditions
- `CommonConversionsExtension.cpp` — type conversion expressions
- `ExternalLayoutsExtension.cpp` — external layout instantiation

---

## Event Types (`BuiltinCommonInstructions`)

These are used as the `"type"` field at the top level of an event object,
not inside `"conditions"` or `"actions"`.

| Event type value | Description |
|-----------------|-------------|
| `BuiltinCommonInstructions::Standard` | Standard event — conditions + actions |
| `BuiltinCommonInstructions::Else` | Runs if previous event(s) in chain were false |
| `BuiltinCommonInstructions::While` | Repeats while conditions are true |
| `BuiltinCommonInstructions::Repeat` | Repeats a fixed number of times |
| `BuiltinCommonInstructions::ForEach` | Repeats for each instance of an object |
| `BuiltinCommonInstructions::ForEachChildVariable` | Repeats for each child of a structure/array |
| `BuiltinCommonInstructions::Group` | Event group (organisational) |
| `BuiltinCommonInstructions::Comment` | Comment block |
| `BuiltinCommonInstructions::Link` | Link to external events |

**Standard event JSON structure:**
```json
{
  "type": "BuiltinCommonInstructions::Standard",
  "conditions": [],
  "actions": [],
  "events": []
}
```

**Repeat event example:**
```json
{
  "type": "BuiltinCommonInstructions::Repeat",
  "repeatExpression": "5",
  "conditions": [],
  "actions": []
}
```

**ForEach event example:**
```json
{
  "type": "BuiltinCommonInstructions::ForEach",
  "object": "Enemy",
  "conditions": [],
  "actions": []
}
```

---

## Control Flow Conditions (`BuiltinCommonInstructions`)

### [CONDITION] `BuiltinCommonInstructions::Once`
**Label:** Trigger once while true
**Description:** Runs actions once when conditions become true. Resets when conditions go false then true again.
**Parameters:** none

```json
{
  "type": { "value": "BuiltinCommonInstructions::Once" },
  "parameters": []
}
```

### [CONDITION] `BuiltinCommonInstructions::Or`
**Label:** Or
**Description:** True if at least one sub-condition is true.
**Parameters:** none (sub-conditions defined as nested conditions)

### [CONDITION] `BuiltinCommonInstructions::And`
**Label:** And
**Description:** True if all sub-conditions are true.
**Parameters:** none

### [CONDITION] `BuiltinCommonInstructions::Not`
**Label:** Not
**Description:** Inverts the result of sub-condition(s).
**Parameters:** none

### [CONDITION] `BuiltinCommonInstructions::CompareNumbers`
**Label:** Compare two numbers
**Sentence:** _PARAM0_ _PARAM1_ _PARAM2_
**Parameters:**
- PARAM0: (expression) First value
- PARAM1: (relationalOperator) Sign — `">"`, `">="`, `"="`, `"<"`, `"<="`, `"!="`
- PARAM2: (expression) Second value

```json
{
  "type": { "value": "BuiltinCommonInstructions::CompareNumbers" },
  "parameters": ["MyVar", ">", "10"]
}
```

### [CONDITION] `BuiltinCommonInstructions::CompareStrings`
**Label:** Compare two strings
**Parameters:**
- PARAM0: (string) First string
- PARAM1: (relationalOperator) Sign
- PARAM2: (string) Second string

---

## Conversion Expressions (`BuiltinCommonConversions`)

### [EXPRESSION] `ToNumber`
**Description:** Convert text to a number.
**Parameters:** PARAM0: (string) Text to convert

**Usage:** `ToNumber("42")` → `42`

### [STR_EXPRESSION] `ToString`
**Description:** Convert a number expression to text.
**Parameters:** PARAM0: (expression) Number expression

**Usage:** `ToString(Score)` → `"42"`

### [STR_EXPRESSION] `LargeNumberToString`
**Description:** Convert number to text without scientific notation.
**Parameters:** PARAM0: (expression) Number expression

### [EXPRESSION] `ToRad`
**Description:** Convert degrees to radians.
**Parameters:** PARAM0: (expression) Angle in degrees

### [EXPRESSION] `ToDeg`
**Description:** Convert radians to degrees.
**Parameters:** PARAM0: (expression) Angle in radians

### [STR_EXPRESSION] `ToJSON`
**Description:** Convert any variable to a JSON string.
**Parameters:** PARAM0: (variable) Variable to stringify

### [STR_EXPRESSION] `ObjectVarToJSON`
**Description:** Convert an object variable to a JSON string.
**Parameters:**
- PARAM0: (objectPtr) Object
- PARAM1: (objectvar) Object variable

### [ACTION] `JSONToVariableStructure2`
**Label:** Convert JSON to a variable
**Sentence:** Convert JSON string _PARAM0_ and store it into variable _PARAM1_
**Parameters:**
- PARAM0: (string) JSON string
- PARAM1: (variable) Target variable

```json
{
  "type": { "value": "JSONToVariableStructure2" },
  "parameters": ["\"[1,2,3]\"", "MyArray"]
}
```

### [ACTION] `JSONToObjectVariableStructure`
**Label:** Convert JSON to object variable
**Sentence:** Parse JSON string _PARAM0_ and store it into variable _PARAM2_ of _PARAM1_
**Parameters:**
- PARAM0: (string) JSON string
- PARAM1: (objectPtr) Object
- PARAM2: (objectvar) Object variable

---

## External Layouts (`BuiltinExternalLayouts`)

### [ACTION] `CreateObjectsFromExternalLayout`
**Label:** Create objects from an external layout
**Sentence:** Create objects from the external layout named _PARAM1_ at position _PARAM2_;_PARAM3_;_PARAM4_
**Parameters:**
- PARAM0: (externalLayoutName) Name of the external layout
- PARAM1: (expression) X position of origin — default `0`
- PARAM2: (expression) Y position of origin — default `0`
- PARAM3: (expression) Z position of origin — default `0`

```json
{
  "type": { "value": "CreateObjectsFromExternalLayout" },
  "parameters": ["\"HUDLayout\"", "0", "0", "0"]
}
```