# Sticker (Common Extension)

Coverage status: `Verified`.

## Source

- Capture record: `docs/captures/2026-04-08-sticker-capture.md`
- Project evidence:
  - `C:\GameDev\Dark_Ship\externalEvents\create-scrap-card.json`
  - `C:\GameDev\Dark-Ship-Codex\layouts\ai-test.json`
- Extension export used during verification:
  - `C:\GameDev\Skills\Extension Exports\Sticker.json`

## Scope Summary

- Extension family: Common Extension
- Behavior name in parameters: `Sticker`
- Serialized behavior scope identifier observed in capture: `Sticker::Sticker`
- Verified serialized entries: `3`
  - `Sticker::Sticker::Stick` (Action)
  - `Sticker::IsStuck` (Condition)
  - `Sticker::Sticker::Unstick` (Action)

## Verified Catalog

| Kind | Internal Name (`type.value`) | Parameter Order | Evidence |
|---|---|---|---|
| Action | `Sticker::Sticker::Stick` | `Object`, `BehaviorName`, `BasisObject`, `ExtraObjectListOrEmpty` | `create-scrap-card.json` line 526 |
| Condition | `Sticker::IsStuck` | `InvertedFlagOrEmpty`, `Object`, `BehaviorName`, `BasisObject`, `ExtraObjectListOrEmpty` | `ai-test.json` line 858 |
| Action | `Sticker::Sticker::Unstick` | `Object`, `BehaviorName`, `ExtraObjectListOrEmpty` | `ai-test.json` line 872 |

## Serialized JSON Samples

Stick:

```json
{
  "type": { "value": "Sticker::Sticker::Stick" },
  "parameters": ["Price", "Sticker", "Card", ""]
}
```

Is stuck:

```json
{
  "type": { "value": "Sticker::IsStuck" },
  "parameters": ["", "TestText", "Sticker", "TestSprite", ""]
}
```

Unstick:

```json
{
  "type": { "value": "Sticker::Sticker::Unstick" },
  "parameters": ["TestText", "Sticker", ""]
}
```

## Parameter Notes

- `IsStuck` includes a leading placeholder parameter (`""`) before object parameters.
- Sticker actions observed here include a trailing placeholder parameter (`""`).
- Keep placeholder slots when editing JSON manually; dropping them can break instruction decoding in editor/runtime.

## Compatibility And Caution

- Compatibility: `KnownInSource`
- Caution: `Normal`
- No `Experimental` or `Deprecated` flag observed in this capture set.
- No object-type incompatibility was observed in captured Sticker usage, but this has not been exhaustively validated across all object families.

## Maintenance Notes

- If new Sticker instructions appear, append them here with:
  - exact `type.value`
  - parameter order
  - one concrete project evidence location
- Keep this file focused on serialized JSON usage; store capture process details in `docs/captures/`.
