# FireBullet Extension Capture (2026-05-01)

## Extension

- Name: FireBullet
- Full name: Fire bullets
- Category: Game mechanic
- Status: Drafted
- Owner: Codex + user
- Date: 2026-05-01

## Source Of Truth

- Extension export JSON: `C:\GameDev\AI-Playground\exported_extensions\FireBullet.json`
- Split installed JSON: `C:\GameDev\AI-Playground\eventsFunctionsExtensions\firebullet.json`
- Validation project: `C:\GameDev\AI-Playground\AI Playground.json`
- Reviewed source JSON: https://github.com/GDevelopApp/GDevelop-extensions/blob/main/extensions/reviewed/FireBullet.json
- Wiki documentation:
  - https://wiki.gdevelop.io/gdevelop5/extensions/fire-bullet/
  - https://wiki.gdevelop.io/gdevelop5/extensions/fire-bullet/details/
  - https://wiki.gdevelop.io/gdevelop5/extensions/fire-bullet/diagrams/
- Extension install shape:
  - [x] Split `eventsFunctionsExtensions/firebullet.json` file
  - [ ] Inline `eventsFunctionsExtensions` object in project JSON

## Recovery Note

Earlier FireBullet serialized event evidence was invalidated after
`AI Playground.json` was restored from a malformed/BOM-bearing edit. The trusted
saved-project evidence below was recaptured from the restored project by adding
Scenario 1, then Scenario 2, then Scenario 3 incrementally. After each scenario,
the project remained valid UTF-8 without BOM, exported with gdexporter, and
passed Playwright smoke.

## Evidence Collected

From `FireBullet.json`:

- Extension version: `0.9.2`
- Extension category: `Game mechanic`
- `eventsBasedBehaviors`: `1`
- Behavior name: `FireBullet`
- Behavior type: `FireBullet::FireBullet`
- Behavior description says the behavior handles cooldown, ammo, reloading, and
  overheating internally, and that fire actions can be called continuously.

From restored project JSON:

- Project reference: `/eventsFunctionsExtensions/firebullet`
- Split file: `C:\GameDev\AI-Playground\eventsFunctionsExtensions\firebullet.json`
- Test groups:
  - `FireBullet Validation - Scenario 1`
  - `FireBullet Validation - Scenario 2`
  - `FireBullet Validation - Scenario 3`
- Test objects:
  - `FireBullet_Shooter`
  - `FireBullet_Target`
  - `FireBullet_Bullet`
  - `FireBullet_ResultText`
  - `FireBullet_SpreadLabel`
- Behavior instance:
  - object: `FireBullet_Shooter`
  - behavior name: `FireBullet`
  - behavior type: `FireBullet::FireBullet`

## Serialized Entries

Trusted representative entries from restored `AI Playground.json`.

### Scenario 1: Basic Visible Firing

| Kind | Internal `type.value` | Serialized `parameters` |
|---|---|---|
| Action | `FireBullet::FireBullet::SetBulletLayer` | `["FireBullet_Shooter","FireBullet","",""]` |
| Action | `FireBullet::FireBullet::SetCooldownOp` | `["FireBullet_Shooter","FireBullet","=","0.12",""]` |
| Action | `FireBullet::FireBullet::FireTowardObject` | `["FireBullet_Shooter","FireBullet","FireBullet_Shooter.X() + 48","FireBullet_Shooter.Y() + 12","FireBullet_Bullet","FireBullet_Target","420",""]` |
| Condition | `FireBullet::FireBullet::HasJustFired` | `["FireBullet_Shooter","FireBullet",""]` |
| Condition | `FireBullet::FireBullet::IsReadyToShoot` | `["FireBullet_Shooter","FireBullet",""]` |

Trusted expressions:

- `FireBullet_Shooter.FireBullet::TotalShotsFired()`
- `FireBullet_Shooter.FireBullet::TotalBulletsCreated()`
- `FireBullet_Shooter.FireBullet::BulletLayer()`

### Scenario 2: Ammo And Reload

| Kind | Internal `type.value` | Serialized `parameters` |
|---|---|---|
| Action | `FireBullet::FireBullet::SetUnlimitedAmmo` | `["FireBullet_Shooter","FireBullet","no",""]` |
| Action | `FireBullet::FireBullet::SetShotsPerReloadOp` | `["FireBullet_Shooter","FireBullet","=","3",""]` |
| Action | `FireBullet::FireBullet::SetReloadDurationOp` | `["FireBullet_Shooter","FireBullet","=","0.6",""]` |
| Action | `FireBullet::FireBullet::ReloadAmmo` | `["FireBullet_Shooter","FireBullet",""]` |
| Condition | `FireBullet::FireBullet::IsReloadNeeded` | `["FireBullet_Shooter","FireBullet",""]` |
| Condition | `FireBullet::FireBullet::IsReloadInProgress` | `["FireBullet_Shooter","FireBullet",""]` |
| Condition | `FireBullet::FireBullet::IsUnlimitedAmmo` | `["FireBullet_Shooter","FireBullet",""]` |

Trusted expressions:

- `FireBullet_Shooter.FireBullet::ShotsBeforeNextReload()`
- `FireBullet_Shooter.FireBullet::ReloadTimeLeft()`

### Scenario 3: Spread And Overheat

| Kind | Internal `type.value` | Serialized `parameters` |
|---|---|---|
| Action | `FireBullet::FireBullet::SetBulletQuantityOp` | `["FireBullet_Shooter","FireBullet","=","3",""]` |
| Action | `FireBullet::FireBullet::SetAngleVarianceOp` | `["FireBullet_Shooter","FireBullet","=","18",""]` |
| Action | `FireBullet::FireBullet::SetBulletSpeedVarianceOp` | `["FireBullet_Shooter","FireBullet","=","40",""]` |
| Action | `FireBullet::FireBullet::SetHeatPerShotOp` | `["FireBullet_Shooter","FireBullet","=","0.35",""]` |
| Action | `FireBullet::FireBullet::SetOverheatDurationOp` | `["FireBullet_Shooter","FireBullet","=","0.8",""]` |
| Condition | `FireBullet::FireBullet::IsOverheated` | `["FireBullet_Shooter","FireBullet",""]` |

Trusted expressions:

- `FireBullet_Shooter.FireBullet::HeatLevel()`
- `FireBullet_Shooter.FireBullet::CooldownTimeLeft()`

## Behavior Modifiers

Behavior properties from `propertyDescriptors`:

| Property Name | Label | Type | Default | Notes |
|---|---|---|---|---|
| `FireCooldown` | Firing cooldown | Number | `0.1` | Seconds between allowed shots. |
| `RotateBullet` | Rotate bullets to match their trajectory | Boolean | `true` | Rotates fired bullets along trajectory. |
| `FiringArc` | Firing arc | Number | `45` | Multi-fire arc in degrees. |
| `BulletQuantity` | Number of bullets created at once | Number | `1` | Bullets per firing action. |
| `AngleVariance` | Angle variance | Number | `0` | Random aim variance in degrees. |
| `BulletSpeedVariance` | Bullet speed variance | Number | `0` | Random speed variance in pixels per second. |
| `ShotsPerReload` | Shots per reload | Number | `0` | `0` disables reloading. |
| `ReloadDuration` | Reloading duration | Number | `1` | Seconds spent reloading. |
| `MaxAmmo` | Max ammo | Number | `0` | Advanced ammo property. |
| `StartingAmmo` | Starting ammo | Number | `0` | Advanced ammo property. |
| `UnlimitedAmmo` | Unlimited ammo | Boolean | `true` | Default unlimited ammo setting. |
| `HeatIncreasePerShot` | Heat increase per shot | Number | `0` | Object overheats when heat reaches 1. |
| `AutomaticReloading` | Reload automatically | Boolean | `true` | Controls automatic reload behavior. |
| `OverheatDuration` | Overheat duration | Number | `0` | Seconds blocked after overheating. |
| `LinearCoolingRate` | Linear cooling rate | Number | `0.1` | Heat cooling rate per second. |
| `ExponentialCoolingRate` | Exponential cooling rate | Number | `0.3` | Faster cooling when heat is high. |
| `BulletLayer` | Layer the bullets are created on | String | empty | Hidden property; base layer by default. |

Hidden runtime state properties observed include `HasJustFired`,
`AmmoQuantity`, `ShotsBeforeNextReload`, `TotalShotsFired`,
`TotalBulletsCreated`, `TotalReloadsCompleted`, `ReloadInProgress`,
`HeatLevel`, and `RandomizedAngle`.

## Validation Results

- [x] Static source metadata reviewed
- [x] Saved project JSON serialization checked in the restored project
- [x] Split install shape checked
- [x] HTML5 export succeeded after Scenario 1, Scenario 2, and Scenario 3
- [x] Playwright smoke passed after Scenario 1, Scenario 2, and Scenario 3
- [ ] Human visual behavior reviewed

Commands run after Scenario 2 and again after Scenario 3:

```powershell
.\scripts\invoke-extension-validation.ps1 -ExtensionName FireBullet -RequireSplitInstall
.\scripts\invoke-extension-validation.ps1 -ExtensionName FireBullet -ExportHtml5 -UseNpxGdexporter
$env:GDEVELOP_EXPORT_DIR = "C:\GameDev\AI-Playground\html5-validation\firebullet"
npx playwright test
```

Final Scenario 3 result: static validation passed, gdexporter exported for
HTML5, and Playwright passed against
`C:\GameDev\AI-Playground\html5-validation\firebullet` with 1 canvas, 0 console
errors, 0 page errors, and 0 failed requests.

## Human Review Prompts

Not completed in this pass. The exported build is ready for human visual review.

- Basic firing: Do bullets visibly spawn from `FireBullet_Shooter` and travel
  toward `FireBullet_Target`?
- Ammo/reload: Does the result text show a finite-ammo/reload state instead of
  unlimited fire?
- Spread/overheat: Does the test visibly demonstrate multiple bullets/spread
  and an overheat state in the debug text?

## Human Test Failure

Human/playable testing on 2026-05-02 failed. After the mouse/touch condition was
corrected by the user, clicking still did not create a `FireBullet_Bullet`
instance. The GDevelop debugger showed no bullet object being created. A likely
area to investigate later is finite-ammo initialization for the FireBullet
behavior.

## Remaining Gaps

- Human visual review is failed/incomplete.
- Determine why clicking does not create a bullet object.
- Check whether the FireBullet behavior needs explicit starting ammo or max ammo
  setup before finite-ammo firing works.
- If human review finds behavior issues, adjust the validation events in small
  increments and repeat static validation, gdexporter export, and Playwright
  smoke before changing this capture.

## Ready For Reference File?

- [x] At least one verified action/condition/expression recorded in the restored project
- [x] Parameter order captured from restored saved project JSON
- [x] Behavior modifiers captured from source metadata
- [x] Install shape documented
- [x] Restored saved project JSON evidence captured
- [x] Evidence links and file paths recorded
- [ ] Safe to mark `references/extensions/fire-bullet.md` as verified
