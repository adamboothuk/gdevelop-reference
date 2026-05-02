# Extension Coverage Targets

Use this file as the single source of truth for what extension coverage is
planned, in progress, or finished.

## Target List

| Extension | Category | Status | Priority | Reference File | Source Notes | Last Updated | GitHub Link |
|---|---|---|---|---|---|---|---|
| Sticker | Common Extension | Verified | High | `references/extensions/sticker.md` | Verified all core serialized entries from project JSON: `Sticker::Sticker::Stick` (`Dark_Ship/externalEvents/create-scrap-card.json` line 526), `Sticker::IsStuck` and `Sticker::Sticker::Unstick` (`Dark-Ship-Codex/layouts/ai-test.json` lines 858 and 872). | 2026-04-09 | TBD |
| Smooth camera | Common Extension | Backlog | High | `references/extensions/smooth-camera.md` | Need verified behavior/action naming and parameter order | 2026-04-08 | TBD |
| ArrayTools | Common Extension | Drafted | High | `references/extensions/arraytools.md` | Metadata extracted from `Extension Exports/ArrayTools.json` (93 functions), reviewed source/wiki noted, and validation targets defined for `C:\GameDev\AI-Playground`. Serialized examples still need a later validation pass. | 2026-05-01 | TBD |
| FireBullet | Common Extension | Backlog | High | `references/extensions/fire-bullet.md` | Source metadata captured and technical export smoke passed, but human/playable testing failed: clicking did not create a visible `FireBullet_Bullet` instance and the debugger showed no bullet object being created. Possible ammo initialization issue. Return to this later before treating the reference as drafted/verified. | 2026-05-02 | TBD |

## Notes

- Keep one row per extension.
- Only move to `Verified` after the checks in `docs/extension-support-workflow.md` are complete.
- When you open a GitHub issue, replace `TBD` with the issue URL.
