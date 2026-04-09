# Sticker Extension Capture (2026-04-08)

## Extension

- Name: Sticker
- Category: Common Extension
- Status: Verified
- Owner: Codex + user
- Date: 2026-04-08

## Source Of Truth

- Editor capture location (project/scene/event): `Dark_Ship/externalEvents/create-scrap-card.json` action at line 526.
- JSON sample file path: `C:\GameDev\Dark_Ship\externalEvents\create-scrap-card.json`.
- GDevelop source link (optional): Local extension export file `C:\GameDev\Skills\Extension Exports\Sticker.json`.

## Evidence Collected In This Pass

1. Initial pass found no Sticker source folder in local `GDevelop-master/Extensions` snapshot.
2. User provided project JSON evidence with action:
   - `type.value`: `Sticker::Sticker::Stick`
   - parameters: `["Price","Sticker","Card",""]`
3. User provided extension export `Sticker.json` with behavior/function metadata:
   - behavior: `Sticker`
   - behavior action names: `Stick`, `Unstick`
   - extension condition name: `IsStuck`
   - behavior parameter supplementary information: `Sticker::Sticker`
4. User provided direct project JSON samples for all three serialized entries in
   `C:\GameDev\Dark-Ship-Codex\layouts\ai-test.json`:
   - `Sticker::Sticker::Stick` (line 842)
   - `Sticker::IsStuck` (line 858)
   - `Sticker::Sticker::Unstick` (line 872)

## Verified Entries

### Actions

Verified from project JSON:

| UI intent | Internal `type.value` | Parameter Order | Evidence |
|---|---|---|---|
| Stick object to basis object | `Sticker::Sticker::Stick` | `Object`, `BehaviorName`, `BasisObject`, `ExtraObjectListOrEmpty` | `C:\GameDev\Dark_Ship\externalEvents\create-scrap-card.json` line 526 |
| Unstick object from basis object | `Sticker::Sticker::Unstick` | `Object`, `BehaviorName`, `ExtraObjectListOrEmpty` | `C:\GameDev\Dark-Ship-Codex\layouts\ai-test.json` line 872 |

### Conditions

Verified from project JSON:

| UI intent | Internal `type.value` | Parameter Order | Evidence |
|---|---|---|---|
| Check if object is stuck to basis object | `Sticker::IsStuck` | `InvertedFlagOrEmpty`, `Object`, `BehaviorName`, `BasisObject`, `ExtraObjectListOrEmpty` | `C:\GameDev\Dark-Ship-Codex\layouts\ai-test.json` line 858 |

### Expressions

No verified entries yet.

## Notes / Gotchas

- Do not infer IDs from UI label text or translation files.
- `Stick` is now verified from real project event JSON.
- `IsStuck` and `Unstick` are now verified from event JSON.
- `IsStuck` includes a leading placeholder parameter (`""`) for the inverted flag slot.
- `Stick` and `Unstick` include a trailing placeholder parameter (`""`) in observed samples.

## Next Capture Steps

1. Watch for additional Sticker instructions in future versions and append if discovered.

## Ready For Reference File?

- [x] At least one verified action/condition/expression recorded
- [x] Parameter order validated
- [x] Evidence links or file paths recorded
- [x] Safe to draft `references/extensions/sticker.md`
