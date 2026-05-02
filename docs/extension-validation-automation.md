# GDevelop Extension Validation Automation

This workflow supports extension-reference tasks by turning source/wiki research
into saved GDevelop project evidence and, when possible, an HTML5 browser smoke
test.

For the broader testing strategy, especially agent-facing knowledge tests, see
`docs/extension-knowledge-test-strategy.md`.

## Approved Fixture

Use this project for validation work unless the user names a different fixture:

```text
C:\GameDev\AI-Playground\AI Playground.json
```

Do not edit production game projects just to create reference evidence.

## Workflow

1. Research the extension.
   - Use the reviewed extension JSON as the source of truth for metadata.
   - Use the GDevelop wiki page for user-facing guidance.
   - Update the matching `references/extensions/<extension>.md` draft.
2. Add validation cases to AI-Playground.
   - Install the extension using the split object reference pattern by default.
   - Store the extension JSON at `eventsFunctionsExtensions/<extension>.json`.
   - Add a project reference to `/eventsFunctionsExtensions/<extension>`.
   - Write JSON as UTF-8 without BOM. Do not use tools that rewrite the whole
     project with a BOM or PowerShell-style formatting.
   - Add the smallest useful events that exercise representative actions,
     conditions, expressions, behavior setup, and edge cases.
   - Save the project so the serialized JSON can be inspected.
3. Inspect saved project JSON.
   - Confirm the extension is installed as a split reference to
     `eventsFunctionsExtensions/<extension>.json`.
   - Capture exact `type.value` and `parameters` arrays for the test events.
   - Copy evidence into the extension capture note.
4. Export to HTML5 when the exporter is available.
   - Preferred tool under evaluation: `gdexporter`.
   - Repository: https://github.com/arthuro555/gdexporter
   - The README documents `gdexport --project <game.json> --out <directory>`.
   - If no build type is supplied, gdexporter exports HTML5.
5. Serve the exported build locally.
   - Use a simple static server from the export directory.
   - Open the local URL in a browser and check console/runtime errors.
6. Iterate.
   - If project JSON serialization is wrong, fix the GDevelop test events or
     reference documentation.
   - If runtime/browser errors appear, record them in the backlog task and
     decide whether they are extension setup issues, exporter issues, or test
     design issues.

## Helper Script

Use:

```powershell
.\scripts\invoke-extension-validation.ps1 -ExtensionName ArrayTools
```

Optional HTML5 export when `gdexport` is installed:

```powershell
.\scripts\invoke-extension-validation.ps1 -ExtensionName ArrayTools -ExportHtml5
```

Optional HTML5 export using temporary `npx` package execution:

```powershell
.\scripts\invoke-extension-validation.ps1 -ExtensionName ArrayTools -ExportHtml5 -UseNpxGdexporter
```

Optional local browser smoke after export:

```powershell
.\scripts\invoke-extension-validation.ps1 -ExtensionName ArrayTools -BrowserSmoke
```

Playwright browser smoke with console/page/request checks:

```powershell
npx playwright test
```

To target a different export directory:

```powershell
$env:GDEVELOP_EXPORT_DIR = "C:\GameDev\AI-Playground\html5-validation\firebullet"
npx playwright test
```

The PowerShell script performs static project inspection and optional gdexporter
execution. The Playwright test starts a local static server, loads the exported
game, checks that a canvas exists, and fails on console errors, page errors, or
failed requests.

The helper script fails fast if the project JSON starts with a UTF-8 BOM,
because gdexporter can reject BOM-prefixed project files as corrupted or
malformed.

To require the preferred split install shape:

```powershell
.\scripts\invoke-extension-validation.ps1 -ExtensionName FireBullet -RequireSplitInstall
```

## Evidence To Capture

For each extension task, capture:

- project path
- extension install shape: split preferred, inline only when explicitly justified
- extension file path when split
- test scene or external event name
- serialized `type.value`
- serialized `parameters`
- HTML5 export command/result if attempted
- browser smoke-test result or explicit reason it was not run

## Current Limits

- `gdexporter` is not bundled with this skill. Install/check it separately.
- `gdexport --help` is not a reliable lightweight capability check: it can load
  GDCore and attempt to open a default project. Prefer an actual export test on
  AI-Playground.
- Export success does not prove behavior is correct; it only catches export and
  obvious runtime errors.
- Current browser smoke confirms that Chrome can load the exported page without
  process failure.
- The Playwright smoke script adds console error, page error, failed request,
  and canvas existence checks for exported HTML5 builds.
- Some extension behavior still needs manual GDevelop editor setup to create
  trustworthy serialized JSON.
- Existing validation fixtures may still contain older inline extension installs.
  New extension validation work should prefer split files to keep the main
  project JSON smaller and easier to review.
- A BOM at the start of `AI Playground.json` is considered a fixture
  corruption. Restore or rewrite the file as UTF-8 without BOM before
  continuing.
