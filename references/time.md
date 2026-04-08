# GDevelop Time Reference

Extracted from `TimeExtension.cpp`. Extension ID: `BuiltinTime`.

> Most entries add `AddCodeOnlyParameter("currentScene", "")` first. Do not
> include that internal parameter in JSON `parameters[]`.

## Open This File When

- the task uses scene timers
- the task changes or checks time scale
- the task uses the `Wait` action
- the task reads delta time, scene time from start, or current system time

## Conditions

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `CompareTimer` | timerName, operator, seconds |
| CONDITION | `TimeScale` | operator, value |
| CONDITION | `TimerPaused` | timerName |

Deprecated hidden timer condition:

| Type | Name | Parameters |
|------|------|------------|
| CONDITION | `Timer` | seconds, timerName |

## Actions

| Type | Name | Parameters |
|------|------|------------|
| ACTION | `ResetTimer` | timerName |
| ACTION | `PauseTimer` | timerName |
| ACTION | `UnPauseTimer` | timerName |
| ACTION | `RemoveTimer` | timerName |
| ACTION | `ChangeTimeScale` | scale |
| ACTION | `Wait` | seconds |

## Expressions

| Type | Name | Parameters |
|------|------|------------|
| EXPRESSION | `TimeDelta` | none |
| EXPRESSION | `TimerElapsedTime` | timerName |
| EXPRESSION | `TimeFromStart` | none |
| EXPRESSION | `TimeScale` | none |
| EXPRESSION | `Time` | selector |

Hidden aliases:

| Type | Name | Parameters |
|------|------|------------|
| EXPRESSION | `TempsFrame` | none |
| EXPRESSION | `ElapsedTime` | none |
| EXPRESSION | `TempsDebut` | none |

`Time` selector options from the source:

- `"hour"`
- `"min"`
- `"sec"`
- `"mday"`
- `"mon"`
- `"year"`
- `"wday"`
- `"yday"`
- `"timestamp"`

## JSON Examples

Check whether a scene timer has reached 3 seconds:

```json
{
  "type": { "value": "CompareTimer" },
  "parameters": ["\"SpawnTimer\"", ">=", "3"]
}
```

Reset a scene timer:

```json
{
  "type": { "value": "ResetTimer" },
  "parameters": ["\"SpawnTimer\""]
}
```

Wait for half a second:

```json
{
  "type": { "value": "Wait" },
  "parameters": ["0.5"]
}
```
