# FireBullet (Common Extension)

Coverage status: `Backlog` (source/wiki-backed; technical export smoke passed,
but human/playable validation failed).

Parameter arrays below are useful source/project evidence, but do not treat the
playable setup as validated yet. Human testing showed that clicking did not
create a visible bullet object. A likely area to investigate later is ammo
initialization for finite-ammo firing.

## Source

- Export: `C:\GameDev\AI-Playground\exported_extensions\FireBullet.json`
- Capture record: `docs/captures/2026-05-01-fire-bullet-capture.md`
- Reviewed source: `GDevelopApp/GDevelop-extensions/extensions/reviewed/FireBullet.json`
- User-facing docs:
  - https://wiki.gdevelop.io/gdevelop5/extensions/fire-bullet/
  - https://wiki.gdevelop.io/gdevelop5/extensions/fire-bullet/details/
  - https://wiki.gdevelop.io/gdevelop5/extensions/fire-bullet/diagrams/

## Scope Summary

- Extension version: `0.9.2`
- Category: `Game mechanic`
- Events-based behaviors: `1`
- Behavior name: `FireBullet`
- Behavior type: `FireBullet::FireBullet`

FireBullet is a behavior extension. Add the `FireBullet` behavior to the object
that shoots, then use behavior actions to create and move bullet objects.

## When To Use This Extension

Use FireBullet when a shooter needs reusable bullet spawning with built-in
constraints:

- fire cooldown / rate of fire
- finite ammo and reload timing
- automatic or manual reload
- multi-bullet spread
- angle and speed variance
- overheat and cooling
- counters for shots, bullets, and reloads

Prefer FireBullet over custom events when those systems would otherwise need
timers, instance creation, force setup, ammo counters, and reload/overheat state
maintained by hand.

Prefer custom events when the projectile rules are not bullet-like, such as
beam weapons, chain targeting, unusual physics, or projectiles that need highly
custom spawn/movement logic before the first frame.

## Install And Setup

- Install the extension before using its event entries.
- Preferred validation install shape:
  - project reference: `/eventsFunctionsExtensions/firebullet`
  - split file: `eventsFunctionsExtensions/firebullet.json`
- Add behavior `FireBullet` with type `FireBullet::FireBullet` to the shooter
  object.
- Fire actions can be called continuously; source metadata says the behavior
  checks readiness internally.
- Bullet objects are created by the behavior and moved with a permanent force.

## Internal Identifier Pattern

Behavior actions and conditions use:

```text
FireBullet::FireBullet::<FunctionName>
```

Expressions use:

```text
Object.FireBullet::<ExpressionName>()
```

where `FireBullet` is the behavior instance name.

## Core Actions

| Action | Internal `type.value` | Parameters |
|---|---|---|
| Fire bullets toward an angle | `FireBullet::FireBullet::Fire` | Object, Behavior, X position, Y position, Bullet object, Angle, Speed, trailing placeholder |
| Fire bullets toward an object | `FireBullet::FireBullet::FireTowardObject` | Object, Behavior, X position, Y position, Bullet object, Target object, Speed, trailing placeholder |
| Fire bullets toward a position | `FireBullet::FireBullet::FireTowardPosition` | Object, Behavior, X position, Y position, Bullet object, Target X, Target Y, Speed |
| Reload ammo | `FireBullet::FireBullet::ReloadAmmo` | Object, Behavior, trailing placeholder |
| Increase ammo | `FireBullet::FireBullet::IncreaseAmmo` | Object, Behavior |
| Reset total shots fired | `FireBullet::FireBullet::ResetTotalShotsFired` | Object, Behavior |
| Reset total bullets created | `FireBullet::FireBullet::ResetTotalBulletsCreated` | Object, Behavior |
| Reset total reloads completed | `FireBullet::FireBullet::ResetTotalReloadsCompleted` | Object, Behavior |

## Property Setter Actions

Operator actions serialize as Object, Behavior, operator, value, trailing
placeholder.

| Action | Internal `type.value` | Value |
|---|---|---|
| Set firing cooldown | `FireBullet::FireBullet::SetCooldownOp` | seconds |
| Set firing arc | `FireBullet::FireBullet::SetFiringArcOp` | degrees |
| Set angle variance | `FireBullet::FireBullet::SetAngleVarianceOp` | degrees |
| Set bullet speed variance | `FireBullet::FireBullet::SetBulletSpeedVarianceOp` | pixels per second |
| Set bullet quantity | `FireBullet::FireBullet::SetBulletQuantityOp` | bullets per shot |
| Set reload duration | `FireBullet::FireBullet::SetReloadDurationOp` | seconds |
| Set overheat duration | `FireBullet::FireBullet::SetOverheatDurationOp` | seconds |
| Set ammo quantity | `FireBullet::FireBullet::SetAmmoQuantityOp` | ammo quantity |
| Set heat per shot | `FireBullet::FireBullet::SetHeatPerShotOp` | 0 to 1 |
| Set max ammo | `FireBullet::FireBullet::SetMaxAmmoOp` | ammo quantity |
| Set shots per reload | `FireBullet::FireBullet::SetShotsPerReloadOp` | shot count |
| Set linear cooling rate | `FireBullet::FireBullet::SetLinearCoolingRateOp` | per second |
| Set exponential cooling rate | `FireBullet::FireBullet::SetExponentialCoolingRateOp` | per second |

Non-operator setters:

| Action | Internal `type.value` | Parameters |
|---|---|---|
| Set bullet layer | `FireBullet::FireBullet::SetBulletLayer` | Object, Behavior, Layer, trailing placeholder |
| Enable bullet rotation | `FireBullet::FireBullet::SetRotateBullet` | Object, Behavior, yes/no, trailing placeholder |
| Enable unlimited ammo | `FireBullet::FireBullet::SetUnlimitedAmmo` | Object, Behavior, yes/no, trailing placeholder |
| Enable automatic reloading | `FireBullet::FireBullet::SetAutomaticReload` | Object, Behavior, yes/no, trailing placeholder |

Deprecated non-operator setter aliases exist in source metadata, for example
`SetCooldown`, `SetBulletQuantity`, and `SetReloadDuration`. Prefer the `Op`
forms for new event JSON.

## Conditions

| Condition | Internal `type.value` | Parameters |
|---|---|---|
| Has just fired | `FireBullet::FireBullet::HasJustFired` | Object, Behavior, trailing placeholder |
| Is ready to shoot | `FireBullet::FireBullet::IsReadyToShoot` | Object, Behavior, trailing placeholder |
| Is reload needed | `FireBullet::FireBullet::IsReloadNeeded` | Object, Behavior, trailing placeholder |
| Is reload in progress | `FireBullet::FireBullet::IsReloadInProgress` | Object, Behavior, trailing placeholder |
| Is unlimited ammo | `FireBullet::FireBullet::IsUnlimitedAmmo` | Object, Behavior, trailing placeholder |
| Is out of ammo | `FireBullet::FireBullet::IsOutOfAmmo` | Object, Behavior |
| Is overheated | `FireBullet::FireBullet::IsOverheated` | Object, Behavior, trailing placeholder |
| Is firing cooldown active | `FireBullet::FireBullet::IsFiringCooldownActive` | Object, Behavior |
| Is automatic reloading enabled | `FireBullet::FireBullet::IsAutomaticReloadingEnabled` | Object, Behavior |
| Is bullet rotation enabled | `FireBullet::FireBullet::BulletRotationEnabled` | Object, Behavior |

## Expressions

Use the behavior instance name in the expression:

```text
FireBullet_Shooter.FireBullet::TotalShotsFired()
```

| Expression | Returns |
|---|---|
| `Object.FireBullet::TotalShotsFired()` | shots fired; multi-bullet shots count as one shot |
| `Object.FireBullet::TotalBulletsCreated()` | bullets created |
| `Object.FireBullet::TotalReloadsCompleted()` | completed reloads |
| `Object.FireBullet::ShotsBeforeNextReload()` | shots remaining before reload |
| `Object.FireBullet::ReloadTimeLeft()` | seconds before reload finishes |
| `Object.FireBullet::HeatLevel()` | heat level from 0 to 1 |
| `Object.FireBullet::CooldownTimeLeft()` | seconds before cooldown permits firing |
| `Object.FireBullet::OverheatTimeLeft()` | seconds before overheat penalty ends |
| `Object.FireBullet::FiringArc()` | firing arc in degrees |
| `Object.FireBullet::AngleVariance()` | angle variance in degrees |
| `Object.FireBullet::BulletSpeedVariance()` | speed variance in pixels per second |
| `Object.FireBullet::BulletQuantity()` | bullets per shot |
| `Object.FireBullet::Cooldown()` | firing cooldown in seconds |
| `Object.FireBullet::ReloadDuration()` | reload duration in seconds |
| `Object.FireBullet::OverheatDuration()` | overheat duration in seconds |
| `Object.FireBullet::AmmoQuantity()` | current ammo quantity |
| `Object.FireBullet::MaxAmmo()` | max ammo |
| `Object.FireBullet::HeatIncreasePerShot()` | heat added per shot |
| `Object.FireBullet::ShotsPerReload()` | shots per reload |
| `Object.FireBullet::LinearCoolingRate()` | linear cooling rate |
| `Object.FireBullet::ExponentialCoolingRate()` | exponential cooling rate |

String expression:

| Expression | Returns |
|---|---|
| `Object.FireBullet::BulletLayer()` | layer used when bullets are created |

## Behavior Properties

| Property | Type | Default | Purpose |
|---|---|---|---|
| `FireCooldown` | Number | `0.1` | Seconds between shots. |
| `RotateBullet` | Boolean | `true` | Rotates bullets to match trajectory. |
| `FiringArc` | Number | `45` | Arc for multi-fire spread. |
| `BulletQuantity` | Number | `1` | Bullets created at once. |
| `AngleVariance` | Number | `0` | Random angle variance. |
| `BulletSpeedVariance` | Number | `0` | Random speed variance. |
| `ShotsPerReload` | Number | `0` | Use `0` to disable reloading. |
| `ReloadDuration` | Number | `1` | Reload time in seconds. |
| `MaxAmmo` | Number | `0` | Advanced ammo capacity. |
| `StartingAmmo` | Number | `0` | Advanced starting ammo. |
| `UnlimitedAmmo` | Boolean | `true` | Whether ammo is unlimited. |
| `HeatIncreasePerShot` | Number | `0` | Heat added per shot; overheats at 1. |
| `AutomaticReloading` | Boolean | `true` | Whether reload starts automatically. |
| `OverheatDuration` | Number | `0` | Time blocked after overheating. |
| `LinearCoolingRate` | Number | `0.1` | Linear heat cooling rate. |
| `ExponentialCoolingRate` | Number | `0.3` | Exponential heat cooling rate. |
| `BulletLayer` | String | empty | Layer where bullets are created. |

## Verified Examples

Fire a bullet toward an object:

```json
{
  "type": { "value": "FireBullet::FireBullet::FireTowardObject" },
  "parameters": [
    "FireBullet_Shooter",
    "FireBullet",
    "FireBullet_Shooter.X() + 48",
    "FireBullet_Shooter.Y() + 12",
    "FireBullet_Bullet",
    "FireBullet_Target",
    "420",
    ""
  ]
}
```

Configure cooldown:

```json
{
  "type": { "value": "FireBullet::FireBullet::SetCooldownOp" },
  "parameters": ["FireBullet_Shooter", "FireBullet", "=", "0.12", ""]
}
```

Configure finite ammo and reload timing:

```json
{
  "type": { "value": "FireBullet::FireBullet::SetShotsPerReloadOp" },
  "parameters": ["FireBullet_Shooter", "FireBullet", "=", "3", ""]
}
```

Reload when needed:

```json
{
  "type": { "value": "FireBullet::FireBullet::ReloadAmmo" },
  "parameters": ["FireBullet_Shooter", "FireBullet", ""]
}
```

Configure spread and overheat:

```json
{
  "type": { "value": "FireBullet::FireBullet::SetHeatPerShotOp" },
  "parameters": ["FireBullet_Shooter", "FireBullet", "=", "0.35", ""]
}
```

Debug text expression example:

```text
"shots=" + ToString(FireBullet_Shooter.FireBullet::TotalShotsFired())
+ " bullets=" + ToString(FireBullet_Shooter.FireBullet::TotalBulletsCreated())
+ " layer=" + FireBullet_Shooter.FireBullet::BulletLayer()
```

## Validation Status

Completed:

- reviewed source metadata
- split install added to `C:\GameDev\AI-Playground`
- static split-install validation passed
- Scenario 1 saved JSON samples captured for visible firing
- Scenario 2 saved JSON samples captured for ammo and reload
- Scenario 3 saved JSON samples captured for spread and overheat
- restored project exported to HTML5 successfully after each scenario increment
- Playwright smoke passed after each scenario increment

Blocked:

- Human/playable testing failed: no `FireBullet_Bullet` instance was created on
  click.
- Check whether starting ammo or max ammo must be initialized explicitly.

Do not mark this extension `Verified` until human visual review is complete or
the remaining review gap is deliberately split into a follow-up task.
