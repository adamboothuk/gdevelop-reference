# ArrayTools (Common Extension)

Coverage status: `Drafted` (source/wiki-backed; serialized validation pending).

## Source

- Export: `C:\\GameDev\\Skills\\Extension Exports\\ArrayTools.json`
- Capture record: `docs/captures/2026-04-09-arraytools-capture.md`
- Reviewed source: `GDevelopApp/GDevelop-extensions/extensions/reviewed/ArrayTools.json`
- User-facing docs: https://wiki.gdevelop.io/gdevelop5/extensions/array-tools/

## Scope Summary

- Extension version: `3.0.1`
- Total functions: `93`
- Action: `39`
- Condition: `6`
- Expression: `18`
- ExpressionAndCondition: `21`
- StringExpression: `9`

## Notes

- This extension has no `eventsBasedBehaviors` and no behavior modifiers.
- Function names and parameter signatures below are extracted from export metadata.
- Use `ArrayTools::<FunctionName>` as the serialized `type.value` pattern for
  actions and conditions, and `ArrayTools::<FunctionName>(...)` for expressions.
- Serialized scene/project JSON still needs a small validation sample set before
  this reference can be moved to `Verified`.

## When To Use This Extension

Use ArrayTools when a GDevelop event needs a common array operation that would
otherwise require custom JavaScript or a multi-event loop:

- searching an array for a number or string
- checking whether an array contains a value
- copying, combining, slicing, splicing, reversing, sorting, or shuffling arrays
- removing the first or last child while storing the removed value
- calculating number-array values such as sum, min, max, mean, or median
- splitting a string into an array, or joining array children into a string

Prefer built-in variable actions when the operation is a single direct child
read/write. Prefer ArrayTools when the operation is array-wide or order-sensitive.
Do not use ArrayTools as a substitute for choosing the correct variable scope:
scene, global, and object variants are separate entries.

## Install And Scope Guidance

- The extension must be installed in the GDevelop project before its entries can
  be used in event JSON.
- Scene-variable functions use `variable` parameters.
- Global-variable functions use `globalvar` parameters and have a `Global`
  prefix.
- Object-variable functions use `objectList` plus `objectvar` parameters and
  have an `Object` prefix.
- Version `3.0.0` introduced a breaking requirement that variables must be
  declared. Confirm the target variable exists in the correct scope before using
  these entries.

## Internal Identifier Pattern

Every exported entry uses the extension prefix:

```text
ArrayTools::<FunctionName>
```

Examples:

| Entry | Use | Internal name |
|---|---|---|
| Scene action | Append all scene-array children | `ArrayTools::AppendAll` |
| Scene condition | Array has string | `ArrayTools::HasString` |
| Scene expression | Sum of number array | `ArrayTools::Sum(...)` |
| Global action | Append all global-array children | `ArrayTools::GlobalAppendAll` |
| Object action | Append all object-array children | `ArrayTools::ObjectAppendAll` |

## Parameter Order Rules

- The parameter order in the catalog is source-derived from the exported
  `eventsFunctions[].parameters` arrays.
- The official docs include technical notes for internal parameter slots handled
  by GDevelop. Those slots can appear in serialized JSON around the visible
  parameters.
- For scene-variable entries, docs commonly report internal parameter `0` and a
  trailing internal parameter after the visible parameters.
- Object-variable entries include visible object-list parameters before each
  related object variable.
- Until the validation pass is complete, treat exact serialized parameter arrays
  as `Needs serialized verification` unless a real project JSON example has
  been captured.

## Representative JSON Validation Targets

Use `C:\\GameDev\\AI-Playground` to generate these examples during the validation
pass. Capture the saved project JSON and record the exact `type.value` plus
`parameters` array in the capture note.

| Coverage Need | Suggested Entry | Expected identifier | Status |
|---|---|---|---|
| Action | Append all scene-array children | `ArrayTools::AppendAll` | Needs serialized verification |
| Condition | Scene array has string | `ArrayTools::HasString` | Needs serialized verification |
| Expression | Sum of scene number array | `ArrayTools::Sum(...)` | Needs serialized verification |
| ExpressionAndCondition | Index of number | `ArrayTools::IndexOf(...)` | Needs serialized verification |
| StringExpression | Join scene string array | `ArrayTools::Join(...)` | Needs serialized verification |
| Object variables | Append all object-array children | `ArrayTools::ObjectAppendAll` | Needs serialized verification |
| Global variables | Append all global-array children | `ArrayTools::GlobalAppendAll` | Needs serialized verification |

Minimum useful GDevelop examples:

- one scene-variable action, condition, expression, expression-and-condition,
  and string expression
- one object-variable entry that includes two object/object-variable pairs
- one global-variable entry

If any generated JSON disagrees with the source-derived order below, keep the
generated JSON as evidence and update this file rather than guessing.

## Documentation Parity Notes

- The official docs page includes technical notes with:
  - internal JSON `type.value` names
  - internal/hidden parameter slots (for example `parameters 0, N` handled by GDevelop)
- This complements export metadata and helps explain why some serialized arrays
  include leading/trailing placeholder entries.

Source:
- https://wiki.gdevelop.io/gdevelop5/extensions/array-tools/

Current project evidence (Dark-Ship-Codex):
- Scene-level serialized forms observed in real JSON:
  - `ArrayTools::AppendAll`
  - `ArrayTools::HasString`
  - `ArrayTools::Shift`

Current local validation project:
- `C:\\GameDev\\AI-Playground` is available for generating examples on demand.
- ArrayTools is installed using the preferred split extension shape:
  - project reference: `/eventsFunctionsExtensions/arraytools`
  - split file: `C:\\GameDev\\AI-Playground\\eventsFunctionsExtensions\\arraytools.json`
- Serialized usage is present in `AI Playground.json` for:
  - `ArrayTools::HasNumber`
  - `ArrayTools::Reverse`
- HTML5 export with gdexporter and Playwright smoke passed after conversion to
  the split install shape.

Practical rule:
- Treat export metadata as the primary catalog/signature source.
- Use docs technical notes to annotate hidden/internal parameter positions and
  confirm exact JSON `type.value` naming patterns.
- Ask the user for a generated GDevelop project JSON example whenever exact
  serialized parameter order is needed for implementation.

## Function Catalog

### Global variables/Array access

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `GlobalPop` | `Action` | Pop array child | `Array:globalvar, Target:globalvar` |
| `GlobalPopNumber` | `ExpressionAndCondition` | Get and remove last variable from array (as number) | `Array:globalvar` |
| `GlobalPopString` | `StringExpression` | Pop string from array | `Array:globalvar` |
| `GlobalRandomNumberInArray` | `ExpressionAndCondition` | Random number in array | `Array:globalvar` |
| `GlobalRandomStringInArray` | `ExpressionAndCondition` | Random string in array | `Array:globalvar` |
| `GlobalShift` | `Action` | Shift array child | `Array:globalvar, Target:globalvar` |
| `GlobalShiftNumber` | `Expression` | Shift number from array | `Array:globalvar` |
| `GlobalShiftString` | `StringExpression` | Shift string from array | `Array:globalvar` |

### Global variables/Array creation

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `GlobalConcatenate` | `Action` | Combine 2 arrays | `Array:globalvar, OtherArray:globalvar, Target:globalvar` |
| `GlobalFillNumber` | `Action` | Fill array with number | `Array:globalvar, Value:expression, Begin:expression, End:expression` |
| `GlobalSlice` | `Action` | Slice an array | `Array:globalvar, Target:globalvar, Begin:expression, End:expression` |
| `GlobalSplitString` | `Action` | Split string into array | `String:string, Separator:string, Array:globalvar` |

### Global variables/Array manipulation

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `GlobalAppendAll` | `Action` | Append all variable to another array | `Array:globalvar, Target:globalvar` |
| `GlobalFlatten` | `Action` | Flatten array | `Array:globalvar, Deep:yesorno` |
| `GlobalInsertAt` | `Action` | Insert variable at | `Array:globalvar, Index:expression, Target:globalvar` |
| `GlobalReverse` | `Action` | Reverse an array | `Array:globalvar` |
| `GlobalShuffle` | `Action` | Shuffle array | `Array:globalvar` |
| `GlobalSplice` | `Action` | Splice an array | `Array:globalvar, Begin:expression, Count:expression` |

### Global variables/Array search

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `GlobalHasNumber` | `Condition` | Array has number | `Array:globalvar, Value:expression` |
| `GlobalHasString` | `Condition` | Array has string | `Array:globalvar, Value:string` |
| `GlobalIndexOf` | `ExpressionAndCondition` | Index of number | `Array:globalvar, Value:expression` |
| `GlobalIndexOfStr` | `ExpressionAndCondition` | Index of text | `Array:globalvar, Value:string` |
| `GlobalLastIndexOf` | `ExpressionAndCondition` | Last index of number | `Array:globalvar, Value:expression` |
| `GlobalLastIndexOfStr` | `ExpressionAndCondition` | Last index of text | `Array:globalvar, Value:string` |

### Global variables/Number arrays

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `GlobalMax` | `Expression` | Biggest value | `Array:globalvar` |
| `GlobalMean` | `Expression` | Average value | `Array:globalvar` |
| `GlobalMedian` | `Expression` | Median value | `Array:globalvar` |
| `GlobalMin` | `Expression` | Smallest value | `Array:globalvar` |
| `GlobalSort` | `Action` | Sort an array | `Array:globalvar` |
| `GlobalSum` | `Expression` | Sum of array children | `Array:globalvar` |

### Global variables/String arrays

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `GlobalJoin` | `StringExpression` | Join all elements of an array together into a string | `Array:globalvar, Separator:string` |

### Object variables/Array access

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `ObjectPop` | `Action` | Pop array child | `Object:objectList, Array:objectvar, Object:objectList, Target:objectvar` |
| `ObjectPopNumber` | `ExpressionAndCondition` | Get and remove last variable from array (as number) | `Object:objectList, Array:objectvar` |
| `ObjectPopString` | `StringExpression` | Pop string from array | `Object:objectList, Array:objectvar` |
| `ObjectRandomNumberInArray` | `ExpressionAndCondition` | Random number in array | `Object:objectList, Array:objectvar` |
| `ObjectRandomStringInArray` | `ExpressionAndCondition` | Random string in array | `Object:objectList, Array:objectvar` |
| `ObjectShift` | `Action` | Shift array child | `Object:objectList, Array:objectvar, Object:objectList, Target:objectvar` |
| `ObjectShiftNumber` | `Expression` | Shift number from array | `Object:objectList, Array:objectvar` |
| `ObjectShiftString` | `StringExpression` | Shift string from array | `Object:objectList, Array:objectvar` |

### Object variables/Array creation

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `ObjectConcatenate` | `Action` | Combine 2 arrays | `Object:objectList, Array:objectvar, Object:objectList, OtherArray:objectvar, Object:objectList, Target:objectvar` |
| `ObjectFillNumber` | `Action` | Fill array with number | `Object:objectList, Array:objectvar, Value:expression, Begin:expression, End:expression` |
| `ObjectSlice` | `Action` | Slice an array | `Object:objectList, Array:objectvar, Object:objectList, Target:objectvar, Begin:expression, End:expression` |
| `ObjectSplitString` | `Action` | Split string into array | `String:string, Separator:string, Object:objectList, Array:objectvar` |

### Object variables/Array manipulation

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `ObjectAppendAll` | `Action` | Append all variable to another array | `Object:objectList, Array:objectvar, Object:objectList, Target:objectvar` |
| `ObjectFlatten` | `Action` | Flatten array | `Object:objectList, Array:objectvar, Deep:yesorno` |
| `ObjectInsertAt` | `Action` | Insert variable at | `Object:objectList, Array:objectvar, Index:expression, Object:objectList, Target:objectvar` |
| `ObjectReverse` | `Action` | Reverse an array | `Object:objectList, Array:objectvar` |
| `ObjectShuffle` | `Action` | Shuffle array | `Object:objectList, Array:objectvar` |
| `ObjectSplice` | `Action` | Splice an array | `Object:objectList, Array:objectvar, Begin:expression, Count:expression` |

### Object variables/Array search

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `ObjectHasNumber` | `Condition` | Array has number | `Object:objectList, Array:objectvar, Value:expression` |
| `ObjectHasString` | `Condition` | Array has string | `Object:objectList, Array:objectvar, Value:string` |
| `ObjectIndexOf` | `ExpressionAndCondition` | Index of number | `Object:objectList, Array:objectvar, Value:expression` |
| `ObjectIndexOfStr` | `ExpressionAndCondition` | Index of text | `Object:objectList, Array:objectvar, Value:string` |
| `ObjectLastIndexOf` | `ExpressionAndCondition` | Last index of number | `Object:objectList, Array:objectvar, Value:expression` |
| `ObjectLastIndexOfStr` | `ExpressionAndCondition` | Last index of text | `Object:objectList, Array:objectvar, Value:string` |

### Object variables/Number arrays

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `ObjectMax` | `Expression` | Biggest value | `Object:objectList, Array:objectvar` |
| `ObjectMean` | `Expression` | Average value | `Object:objectList, Array:objectvar` |
| `ObjectMedian` | `Expression` | Median value | `Object:objectList, Array:objectvar` |
| `ObjectMin` | `Expression` | Smallest value | `Object:objectList, Array:objectvar` |
| `ObjectSort` | `Action` | Sort an array | `Object:objectList, Array:objectvar` |
| `ObjectSum` | `Expression` | Sum of array children | `Object:objectList, Array:objectvar` |

### Object variables/String arrays

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `ObjectJoin` | `StringExpression` | Join all elements of an array together into a string | `Object:objectList, Array:objectvar, Separator:string` |

### Scene variables/Array access

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `Pop` | `Action` | Pop array child | `Array:variable, Target:variable` |
| `PopNumber` | `ExpressionAndCondition` | Get and remove last variable from array (as number) | `Array:variable` |
| `PopString` | `StringExpression` | Pop string from array | `Array:variable` |
| `RandomNumberInArray` | `ExpressionAndCondition` | Random number in array | `Array:variable` |
| `RandomStringInArray` | `ExpressionAndCondition` | Random string in array | `Array:variable` |
| `Shift` | `Action` | Shift array child | `Array:variable, Target:variable` |
| `ShiftNumber` | `Expression` | Shift number from array | `Array:variable` |
| `ShiftString` | `StringExpression` | Shift string from array | `Array:variable` |

### Scene variables/Array creation

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `Concatenate` | `Action` | Combine 2 arrays | `Array:variable, OtherArray:variable, Target:variable` |
| `FillNumber` | `Action` | Fill array with number | `Array:variable, Value:expression, Begin:expression, End:expression` |
| `Slice` | `Action` | Slice an array | `Array:variable, Target:variable, Begin:expression, End:expression` |
| `SplitString` | `Action` | Split string into array | `String:string, Separator:string, Array:variable` |

### Scene variables/Array manipulation

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `AppendAll` | `Action` | Append all variable to another array | `Array:variable, Target:variable` |
| `Flatten` | `Action` | Flatten array | `Array:variable, Deep:yesorno` |
| `InsertAt` | `Action` | Insert variable at | `Array:variable, Index:expression, Target:variable` |
| `Reverse` | `Action` | Reverse an array | `Array:variable` |
| `Shuffle` | `Action` | Shuffle array | `Array:variable` |
| `Splice` | `Action` | Splice an array | `Array:variable, Begin:expression, Count:expression` |

### Scene variables/Array search

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `HasNumber` | `Condition` | Array has number | `Array:variable, Value:expression` |
| `HasString` | `Condition` | Array has string | `Array:variable, Value:string` |
| `IndexOf` | `ExpressionAndCondition` | Index of number | `Array:variable, Value:expression` |
| `IndexOfStr` | `ExpressionAndCondition` | Index of text | `Array:variable, Value:string` |
| `LastIndexOf` | `ExpressionAndCondition` | Last index of number | `Array:variable, Value:expression` |
| `LastIndexOfStr` | `ExpressionAndCondition` | Last index of text | `Array:variable, Value:string` |

### Scene variables/Number arrays

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `Max` | `Expression` | Biggest value | `Array:variable` |
| `Mean` | `Expression` | Average value | `Array:variable` |
| `Median` | `Expression` | Median value | `Array:variable` |
| `Min` | `Expression` | Smallest value | `Array:variable` |
| `Sort` | `Action` | Sort an array | `Array:variable` |
| `Sum` | `Expression` | Sum of array children | `Array:variable` |

### Scene variables/String arrays

| Function Name | Type | Display Name | Parameters |
|---|---|---|---|
| `Join` | `StringExpression` | Join all elements of an array together into a string | `Array:variable, Separator:string` |

