# GDevelop Scene Reference

Extracted from `SceneExtension.cpp`. Extension ID: `BuiltinScene`.

> Most entries add `AddCodeOnlyParameter("currentScene", "")` first. Do not
> include that internal parameter in JSON `parameters[]`.

## Open This File When

- the task changes scenes or pauses and resumes scene stacks
- the task checks whether a scene just began or resumed
- the task preloads scene assets or checks loading progress
- the task needs scene-level utility actions like quitting the game or setting the background color

## Expressions

| Type | Name | Parameters |
|------|------|------------|
| STR_EXPRESSION | `CurrentSceneName` | none |
| CONDITION and EXPRESSION | `SceneLoadingProgress` | sceneName, operator/value |

Notes:

- `SceneLoadingProgress` is an expression-and-condition entry using standard numeric comparison parameters.
- Condition form is `sceneName, operator, value`.
- Expression form is `sceneName`.

## Conditions

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `SceneJustBegins` | none |
| CONDITION | `SceneJustResumed` | none |
| CONDITION | `DoesSceneExist` | sceneName |
| CONDITION | `HasGameJustResumed` | none |
| CONDITION | `AreSceneAssetsLoaded` | sceneName |

Deprecated hidden alias:

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `DepartScene` | none |

## Actions

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `Scene` | sceneName, stopOtherPausedScenes |
| ACTION | `PushScene` | sceneName |
| ACTION | `PopScene` | none |
| ACTION | `Quit` | none |
| ACTION | `SceneBackground` | color |
| ACTION | `DisableInputWhenFocusIsLost` | yes/no |
| ACTION | `PrioritizeLoadingOfScene` | sceneName |

Notes:

- `Scene` changes to another scene and includes a `yesorno` parameter controlling whether other paused scenes are stopped.
- `PushScene` pauses the current scene and starts a new one.
- `PopScene` stops the current scene and returns to the previous paused scene.
- `PrioritizeLoadingOfScene` preloads scene resources in the background.

## JSON Examples

Change to another scene and stop paused scenes:

```json
{
  "type": { "value": "Scene" },
  "parameters": ["\"GameOver\"", "true"]
}
```

Pause this scene and launch a menu:

```json
{
  "type": { "value": "PushScene" },
  "parameters": ["\"PauseMenu\""]
}
```

Check whether a scene has finished preloading:

```json
{
  "type": { "value": "AreSceneAssetsLoaded" },
  "parameters": ["\"Level2\""]
}
```
