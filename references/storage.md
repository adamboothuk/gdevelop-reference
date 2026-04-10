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
> target variable.
>
> In editor-serialized project JSON, this may still appear as an empty
> placeholder parameter slot. Preserve the exact observed parameter order from
> the project file when editing manually.

## Open This File When

- the task reads or writes persistent save data
- the task clears, deletes, preloads, or unloads storage
- the task checks whether a storage or storage group exists
- the task needs the correct JSON names for `BuiltinFile`

Not for debug log file append/read loops:
- use `references/debug-logging-pattern.md` when the task is runtime log files
  written with `FileSystem::LoadStringFromFileAsync` and
  `FileSystem::SaveStringToFileAsync`.

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

Save text/JSON payload (project-verified pattern):

```json
{
  "type": { "value": "EcrireFichierTxt" },
  "parameters": [
    "\"dark_ship_player_data\"",
    "\"profile/\" + player.profiles.current_profile + \"/equipment\"",
    "ToJSON(player.equipment_db)"
  ]
}
```

Load a string into a variable:

```json
{
  "type": { "value": "ReadStringFromStorage" },
  "parameters": ["\"Save1\"", "\"PlayerState/Name\"", "GlobalVariableString(PlayerName)"]
}
```

Project-verified serialized form with internal placeholder slot:

```json
{
  "type": { "value": "ReadStringFromStorage" },
  "parameters": [
    "\"dark_ship_player_data\"",
    "\"profile/current_profile_ref\"",
    "",
    "LoadTemp"
  ]
}
```

Evidence for project-verified storage snippets:
- `C:\GameDev\Dark-Ship-Codex\layouts\data-import.json:814` (`EcrireFichierTxt`)
- `C:\GameDev\Dark-Ship-Codex\layouts\data-import.json:872` (`EcrireFichierTxt`)
- `C:\GameDev\Dark-Ship-Codex\layouts\data-import.json:919` (`EcrireFichierTxt`)
- `C:\GameDev\Dark-Ship-Codex\layouts\data-import.json:1015` (`ReadStringFromStorage`)

Check whether a nested path exists:

```json
{
  "type": { "value": "GroupExists" },
  "parameters": ["\"Save1\"", "\"PlayerState/CurrentLevel\""]
}
```
