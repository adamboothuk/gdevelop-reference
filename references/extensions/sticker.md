# Sticker (Common Extension)

Coverage status: `Verified`.

## Verified Entries

From project JSON evidence:

| Type | Internal Name (`type.value`) | Parameter Order | Evidence |
|---|---|---|---|
| Action | `Sticker::Sticker::Stick` | `Object`, `BehaviorName`, `BasisObject`, `ExtraObjectListOrEmpty` | `C:\GameDev\Dark_Ship\externalEvents\create-scrap-card.json` line 526 |
| Condition | `Sticker::IsStuck` | `InvertedFlagOrEmpty`, `Object`, `BehaviorName`, `BasisObject`, `ExtraObjectListOrEmpty` | `C:\GameDev\Dark-Ship-Codex\layouts\ai-test.json` line 858 |
| Action | `Sticker::Sticker::Unstick` | `Object`, `BehaviorName`, `ExtraObjectListOrEmpty` | `C:\GameDev\Dark-Ship-Codex\layouts\ai-test.json` line 872 |

Raw JSON samples:

```json
{
  "type": { "value": "Sticker::Sticker::Stick" },
  "parameters": ["Price", "Sticker", "Card", ""]
}
```

```json
{
  "type": { "value": "Sticker::IsStuck" },
  "parameters": ["", "TestText", "Sticker", "TestSprite", ""]
}
```

```json
{
  "type": { "value": "Sticker::Sticker::Unstick" },
  "parameters": ["TestText", "Sticker", ""]
}
```

## Notes

- `IsStuck` includes a leading placeholder parameter (`""`) before object parameters.
- Observed Sticker actions include a trailing placeholder parameter (`""`).

## Capture Record

See: `docs/captures/2026-04-08-sticker-capture.md`
