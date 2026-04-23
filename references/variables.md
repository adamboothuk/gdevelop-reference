# GDevelop Variables Reference

Extracted from `VariablesExtension.cpp`. Extension ID: `BuiltinVariables`.

This is the main built-in reference for generic variable operations. The source
also contains many hidden legacy scene/global-specific forms; those are listed
below for compatibility but should not be preferred in new JSON.

## Open This File When

- the task reads, compares, or writes variables
- the task works with array or structure children
- the task pushes, clears, or removes array entries
- the task needs generic variable JSON rather than object variable JSON

## Preferred Parameter Form (Dark-Ship-Codex Baseline)

Use bare variable paths in BuiltinVariables parameter slots.

- Preferred: `run.sector`, `states.run`, `data.equipment_db`, `eventq`
- Avoid by default: `Variable(...)`, `SceneVariable(...)`, `GlobalVariable(...)`
- Legacy scene/global instruction names remain documented for compatibility, not as
  first choice.

Evidence from `C:\GameDev\Dark-Ship-Codex`:

- `layouts`, `externalEvents`, and `externalLayouts` use modern generic
  instructions (`SetNumberVariable`, `StringVariable`, `ClearVariableChildren`,
  `PushVariable`) with bare variable paths.
- No matches found for `GlobalVariable(`, `VarGlobal`, or `VarScene` in those
  gameplay JSON folders.

## Generic Variable Conditions

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `NumberVariable` | variable, operator, value |
| CONDITION | `StringVariable` | variable, operator, value |
| CONDITION | `BooleanVariable` | variable, true/false |
| CONDITION | `VariableChildCount` | arrayVariable, operator, value |
| CONDITION | `VariableChildExists2` | variable, childName |

Notes:

- `NumberVariable` and `StringVariable` use standard relational operator parameters.
- `BooleanVariable` compares a variable against `true` or `false`.

## Generic Variable Actions

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `SetNumberVariable` | variable, operator, value |
| ACTION | `SetStringVariable` | variable, operator, value |
| ACTION | `SetBooleanVariable` | variable, booleanOperatorValue |
| ACTION | `RemoveVariableChild` | structureVariable, childName |
| ACTION | `ClearVariableChildren` | structureOrArrayVariable |
| ACTION | `PushVariable` | arrayVariable, variableToCopy |
| ACTION | `PushString` | arrayVariable, text |
| ACTION | `PushNumber` | arrayVariable, number |
| ACTION | `PushBoolean` | arrayVariable, true/false |
| ACTION | `RemoveVariableAt` | arrayVariable, index |

## Generic Variable Expressions

| Type | Name | Parameters |
|------|------|------------|
| STR_EXPRESSION | `VariableFirstString` | arrayVariable |
| EXPRESSION | `VariableFirstNumber` | arrayVariable |
| STR_EXPRESSION | `VariableLastString` | arrayVariable |
| EXPRESSION | `VariableLastNumber` | arrayVariable |
| EXPRESSION | `VariableChildCount` | arrayOrStructureVariable |

Notes:

- `PushVariable` copies the content of the source variable into the array.
- `VariableChildCount` exists both as a condition and as an expression with the same name.

## Hidden Legacy Scene Variable Forms

These are hidden and mainly relevant for compatibility or function-event-specific JSON.

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `VarScene` | scenevar, operator, value |
| CONDITION | `VarSceneTxt` | scenevar, operator, value |
| CONDITION | `SceneVariableAsBoolean` | scenevar, true/false |
| CONDITION | `VariableChildExists` | scenevar, childName |
| CONDITION | `VarSceneDef` | variableName |
| ACTION | `ModVarScene` | scenevar, operator, value |
| ACTION | `ModVarSceneTxt` | scenevar, operator, value |
| ACTION | `SetSceneVariableAsBoolean` | scenevar, true/false |
| ACTION | `ToggleSceneVariableAsBoolean` | scenevar |
| ACTION | `VariableRemoveChild` | scenevar, childName |
| ACTION | `VariableClearChildren` | scenevar |
| ACTION | `SceneVariablePush` | sceneArrayVar, sceneVarToCopy |
| ACTION | `SceneVariablePushString` | sceneArrayVar, text |
| ACTION | `SceneVariablePushNumber` | sceneArrayVar, number |
| ACTION | `SceneVariablePushBool` | sceneArrayVar, true/false |
| ACTION | `SceneVariableRemoveAt` | sceneArrayVar, index |
| CONDITION | `SceneVariableChildCount` | sceneArrayVar, operator, value |
| STR_EXPRESSION | `SceneVariableFirstString` | sceneArrayVar |
| EXPRESSION | `SceneVariableFirstNumber` | sceneArrayVar |
| STR_EXPRESSION | `SceneVariableLastString` | sceneArrayVar |
| EXPRESSION | `SceneVariableLastNumber` | sceneArrayVar |
| EXPRESSION | `Variable` | scenevar |
| STR_EXPRESSION | `VariableString` | scenevar |

## Hidden Legacy Global Variable Forms

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `VarGlobal` | globalvar, operator, value |
| CONDITION | `VarGlobalTxt` | globalvar, operator, value |
| CONDITION | `GlobalVariableAsBoolean` | globalvar, true/false |
| CONDITION | `GlobalVariableChildExists` | globalvar, childName |
| CONDITION | `VarGlobalDef` | variableName |
| ACTION | `ModVarGlobal` | globalvar, operator, value |
| ACTION | `ModVarGlobalTxt` | globalvar, operator, value |
| ACTION | `SetGlobalVariableAsBoolean` | globalvar, true/false |
| ACTION | `ToggleGlobalVariableAsBoolean` | globalvar |
| ACTION | `GlobalVariableRemoveChild` | globalvar, childName |
| ACTION | `GlobalVariableClearChildren` | globalvar |
| ACTION | `GlobalVariablePush` | globalArrayVar, sceneVarToCopy |
| ACTION | `GlobalVariablePushString` | globalArrayVar, text |
| ACTION | `GlobalVariablePushNumber` | globalArrayVar, number |
| ACTION | `GlobalVariablePushBool` | globalArrayVar, true/false |
| ACTION | `GlobalVariableRemoveAt` | globalArrayVar, index |
| CONDITION | `GlobalVariableChildCount` | globalArrayVar, operator, value |
| STR_EXPRESSION | `GlobalVariableFirstString` | globalArrayVar |
| EXPRESSION | `GlobalVariableFirstNumber` | globalArrayVar |
| STR_EXPRESSION | `GlobalVariableLastString` | globalArrayVar |
| EXPRESSION | `GlobalVariableLastNumber` | globalArrayVar |
| EXPRESSION | `GlobalVariableChildCount` | globalArrayOrStructureVar |
| EXPRESSION | `GlobalVariable` | globalvar |
| STR_EXPRESSION | `GlobalVariableString` | globalvar |

## JSON Examples (Verified From Dark-Ship-Codex)

Initialize nested run variables with bare paths
(`externalEvents/runfsm_setup.json:69`):

```json
{
  "type": { "value": "SetNumberVariable" },
  "parameters": ["run.seeds.run", "=", "ToNumber(ToString(global.seeds.core) + ToString(global.ship) + ToString(global.rank))"]
}
```

State-machine compare with bare path
(`externalEvents/runfsm.json:28`):

```json
{
  "type": { "value": "StringVariable" },
  "parameters": ["states.run", "=", "\"_init\""]
}
```

Clear structure children before loading JSON
(`layouts/data-import.json:286`):

```json
{
  "type": { "value": "ClearVariableChildren" },
  "parameters": ["data.equipment_db"]
}
```

Push a structure variable into an array variable
(`externalEvents/roomfsm.json:4782`):

```json
{
  "type": { "value": "PushVariable" },
  "parameters": ["eventq", "this_event"]
}
```
