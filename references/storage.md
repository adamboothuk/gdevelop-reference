# GDevelop Storage Reference

Extracted from `FileExtension.cpp`. Extension ID: `BuiltinFile`.

> Storage names and group paths are regular JSON strings.
>
> Group paths use `/` to describe nested structure, for example
> `"PlayerState/CurrentLevel"`.
>
> The source notes that spaces are forbidden in element names.
>
> Some load actions add `AddCodeOnlyParameter("currentScene", "")` before the
> target variable. Do not include that internal parameter in JSON `parameters[]`.

## Open This File When

- the task reads or writes persistent save data
- the task clears, deletes, preloads, or unloads storage
- the task checks whether a storage or storage group exists
- the task needs the correct JSON names for `BuiltinFile`

## Conditions

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `GroupExists` | storageName, groupPath |
| CONDITION | `FileExists` | storageName |

## Actions

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `LoadFile` | storageName |
| ACTION | `UnloadFile` | storageName |
| ACTION | `EcrireFichierExp` | storageName, groupPath, expression |
| ACTION | `EcrireFichierTxt` | storageName, groupPath, text |
| ACTION | `ReadNumberFromStorage` | storageName, groupPath, variable |
| ACTION | `ReadStringFromStorage` | storageName, groupPath, variable |
| ACTION | `DeleteGroupFichier` | storageName, groupPath |
| ACTION | `DeleteFichier` | storageName |
| ACTION | `ExecuteCmd` | command |

Deprecated hidden load actions:

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `LireFichierExp` | storageName, groupPath, sceneVariable |
| ACTION | `LireFichierTxt` | storageName, groupPath, sceneVariable |

Notes:

- `LoadFile` and `UnloadFile` are advanced manual lifecycle controls. Use them only when the task explicitly needs storage pinned in memory.
- `ReadNumberFromStorage` and `ReadStringFromStorage` write into a variable parameter, not a raw expression.
- `ExecuteCmd` exists in the extension source but is advanced and potentially sensitive. Treat it carefully if it appears in user JSON.

## JSON Examples

Save a numeric expression:

```json
{
  "type": { "value": "EcrireFichierExp" },
  "parameters": ["\"Save1\"", "\"PlayerState/Coins\"", "Variable(PlayerCoins)"]
}
```

Load a string into a variable:

```json
{
  "type": { "value": "ReadStringFromStorage" },
  "parameters": ["\"Save1\"", "\"PlayerState/Name\"", "GlobalVariableString(PlayerName)"]
}
```

Check whether a nested path exists:

```json
{
  "type": { "value": "GroupExists" },
  "parameters": ["\"Save1\"", "\"PlayerState/CurrentLevel\""]
}
```
