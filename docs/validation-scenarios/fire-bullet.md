# FireBullet Validation Scenarios

Use these scenarios for `EXT-7`. They are designed to test whether a fresh
agent can use `gdevelop-reference` to select and apply FireBullet actions,
conditions, expressions, and behavior properties without prior context.

## Fixture

- Project: `C:\GameDev\AI-Playground\AI Playground.json`
- Extension source available locally:
  `C:\GameDev\AI-Playground\exported_extensions\FireBullet.json`
- Preferred install shape:
  - project reference: `/eventsFunctionsExtensions/firebullet`
  - split file: `C:\GameDev\AI-Playground\eventsFunctionsExtensions\firebullet.json`
- FireBullet is currently installed in the validation project using the split
  shape.
- No FireBullet validation events are currently present after the project
  restore. Add scenarios incrementally.

## Guardrail

`AI Playground.json` must remain strict JSON without a UTF-8 BOM. Do not use
PowerShell `Set-Content`, `ConvertTo-Json`, or whole-file JSON reserialization
for GDevelop project edits. After each small scenario increment, run:

```powershell
.\scripts\invoke-extension-validation.ps1 -ExtensionName FireBullet -RequireSplitInstall
.\scripts\invoke-extension-validation.ps1 -ExtensionName FireBullet -ExportHtml5 -UseNpxGdexporter
$env:GDEVELOP_EXPORT_DIR = "C:\GameDev\AI-Playground\html5-validation\firebullet"
npx playwright test
```

Only capture saved `type.value` and `parameters` evidence after those checks
pass.

## Baseline Coverage Target

Use up to three examples per available usage type.

Actions:

- `FireBullet::FireBullet::Fire`
- `FireBullet::FireBullet::FireTowardObject`
- `FireBullet::FireBullet::ReloadAmmo`

Action/property setters:

- `FireBullet::FireBullet::SetCooldownOp`
- `FireBullet::FireBullet::SetBulletLayer`
- `FireBullet::FireBullet::SetShotsPerReloadOp`
- `FireBullet::FireBullet::SetReloadDurationOp`
- `FireBullet::FireBullet::SetBulletQuantityOp`
- `FireBullet::FireBullet::SetAngleVarianceOp`
- `FireBullet::FireBullet::SetHeatPerShotOp`
- `FireBullet::FireBullet::SetOverheatDurationOp`
- `FireBullet::FireBullet::SetUnlimitedAmmo`

Conditions:

- `FireBullet::FireBullet::HasJustFired`
- `FireBullet::FireBullet::IsReadyToShoot`
- `FireBullet::FireBullet::IsReloadNeeded`
- `FireBullet::FireBullet::IsReloadInProgress`
- `FireBullet::FireBullet::IsOverheated`
- `FireBullet::FireBullet::IsUnlimitedAmmo`

Expressions:

- `Object.FireBullet::TotalShotsFired()`
- `Object.FireBullet::TotalBulletsCreated()`
- `Object.FireBullet::ShotsBeforeNextReload()`
- `Object.FireBullet::ReloadTimeLeft()`
- `Object.FireBullet::HeatLevel()`
- `Object.FireBullet::CooldownTimeLeft()`

String expressions:

- `Object.FireBullet::BulletLayer()`

Behavior properties to document:

- `FireCooldown`
- `BulletQuantity`
- `AngleVariance`
- `BulletSpeedVariance`
- `ShotsPerReload`
- `ReloadDuration`
- `UnlimitedAmmo`
- `HeatIncreasePerShot`
- `OverheatDuration`
- `BulletLayer`

## Scenario 1: Basic Visible Firing

Goal:
Configure a shooter object with FireBullet, create visible bullets, and fire
toward a visible target.

Required extension:
FireBullet

Required test objects:

- `FireBullet_Shooter`: visible sprite or shape marker at approximately
  `(300, 500)`, behavior name `FireBullet`, type `FireBullet::FireBullet`.
- `FireBullet_Target`: visible sprite or shape marker at approximately
  `(900, 500)`.
- `FireBullet_Bullet`: visible bullet sprite or shape marker.
- `FireBullet_ResultText`: visible text object showing total shots, total
  bullets, has-just-fired state, and ready-to-shoot state.

Required variables:

- Use or create scene variables under a clear `fireBulletTest` structure for
  pass/fail flags and counters.
- Use existing AI-Playground test globals only if they clearly fit the scenario.

Expected extension usage:

- Action: `FireBullet::FireBullet::SetBulletLayer`
- Action: `FireBullet::FireBullet::SetCooldownOp`
- Action: `FireBullet::FireBullet::FireTowardObject`
- Condition: `FireBullet::FireBullet::HasJustFired`
- Condition: `FireBullet::FireBullet::IsReadyToShoot`
- Expression: `FireBullet_Shooter.FireBullet::TotalShotsFired()`
- Expression: `FireBullet_Shooter.FireBullet::TotalBulletsCreated()`
- String expression: `FireBullet_Shooter.FireBullet::BulletLayer()`

Expected visible result:

- Shooter and target are visible.
- Bullet objects visibly spawn from the shooter and travel toward the target.
- Result text updates with shots/bullets counters.

Automated checks:

- Split install check passes:
  `.\scripts\invoke-extension-validation.ps1 -ExtensionName FireBullet -RequireSplitInstall`
- Saved project JSON contains the expected `type.value` values.
- HTML5 export succeeds.
- `npx playwright test` passes with no console/page/request errors.

Human review prompt:
Do bullets visibly spawn from `FireBullet_Shooter` and travel toward
`FireBullet_Target`?

## Scenario 2: Ammo And Reload

Goal:
Validate finite ammo, shots before reload, reload-needed state, and reload
timing.

Required test objects:

- Reuse `FireBullet_Shooter`, `FireBullet_Bullet`, and `FireBullet_ResultText`.

Required variables:

- Scene variable `fireBulletTest.reloadState`.
- Scene variable `fireBulletTest.reloadObserved`.

Expected extension usage:

- Action: `FireBullet::FireBullet::SetUnlimitedAmmo`
- Action: `FireBullet::FireBullet::SetShotsPerReloadOp`
- Action: `FireBullet::FireBullet::SetReloadDurationOp`
- Action: `FireBullet::FireBullet::ReloadAmmo`
- Condition: `FireBullet::FireBullet::IsReloadNeeded`
- Condition: `FireBullet::FireBullet::IsReloadInProgress`
- Condition: `FireBullet::FireBullet::IsUnlimitedAmmo`
- Expression: `FireBullet_Shooter.FireBullet::ShotsBeforeNextReload()`
- Expression: `FireBullet_Shooter.FireBullet::ReloadTimeLeft()`

Expected visible result:

- Result text shows shots remaining decreasing.
- Reload state becomes visible in the result text when reload starts.

Automated checks:

- Saved project JSON contains expected setter, reload, condition, and expression
  usage.
- HTML5 export and Playwright smoke pass.

Human review prompt:
Does the result text show a finite-ammo/reload state instead of unlimited fire?

## Scenario 3: Spread And Overheat

Goal:
Validate multi-bullet spread, angle variance, heat increase, and overheat state.

Required test objects:

- Reuse `FireBullet_Shooter`, `FireBullet_Bullet`, and `FireBullet_ResultText`.
- Add a visible label or marker explaining this is the spread/overheat test.

Required variables:

- Scene variable `fireBulletTest.overheatObserved`.
- Scene variable `fireBulletTest.heatLevel`.

Expected extension usage:

- Action: `FireBullet::FireBullet::SetBulletQuantityOp`
- Action: `FireBullet::FireBullet::SetAngleVarianceOp`
- Action: `FireBullet::FireBullet::SetBulletSpeedVarianceOp`
- Action: `FireBullet::FireBullet::SetHeatPerShotOp`
- Action: `FireBullet::FireBullet::SetOverheatDurationOp`
- Condition: `FireBullet::FireBullet::IsOverheated`
- Expression: `FireBullet_Shooter.FireBullet::HeatLevel()`
- Expression: `FireBullet_Shooter.FireBullet::CooldownTimeLeft()`

Expected visible result:

- Multiple bullets can appear from one firing action.
- Result text shows heat level increasing and overheat state when triggered.

Automated checks:

- Saved project JSON contains expected spread/heat setter usage.
- Saved project JSON contains `IsOverheated` and `HeatLevel` usage.
- HTML5 export and Playwright smoke pass.

Human review prompt:
Does the test visibly demonstrate multiple bullets/spread and an overheat state
in the debug text?

## Evidence Required In The Capture Note

Record:

- install shape and split file path
- source JSON path
- wiki URLs
- object names and behavior name
- exact saved JSON `type.value` values
- exact saved JSON `parameters` arrays for representative entries
- expressions used in text/debug output
- gdexporter result
- Playwright result
- human review prompts and whether they were answered
