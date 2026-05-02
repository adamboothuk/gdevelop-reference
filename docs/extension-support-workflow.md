# Extension Support Workflow

This workflow helps you add GDevelop extension support in small, safe steps
without guessing internal names.

## Goal

For each extension target, we want:

1. A tracked Backlog.md task that is updated as the work progresses.
2. A tracked status in `docs/extension-targets.md`.
3. A verified capture record (from editor/source) using the template.
4. A reference doc added under `references/extensions/`.
5. `SKILL.md` and this repo README updated so the skill can route correctly.

## Status Stages

Use exactly these statuses in `docs/extension-targets.md`:

- `Backlog`: not started yet.
- `Capturing`: collecting verified actions/conditions/expressions.
- `Drafted`: reference file exists but not reviewed.
- `Verified`: reviewed and ready for regular use.
- `Blocked`: waiting on missing source examples or unresolved naming.

## Step-By-Step Process

1. Pick the next extension from the extension Backlog.md board.
2. Move the backlog task to `In Progress` before editing files.
3. Confirm the current Git branch. If it is `main`, create a task branch first.
4. Read the task's references, documentation links, acceptance criteria, and
   implementation plan.
5. Create a new capture file using `docs/extension-capture-template.md`.
3. Fill the capture file only with verified information from:
   - GDevelop event editor labels and generated JSON, or
   - GDevelop source metadata for the extension.
6. Create `references/extensions/<extension-name>.md` with:
   - internal identifiers (`type.value`)
   - parameter order
   - behavior modifier properties (when the extension defines a behavior)
   - examples
   - deprecations or gotchas (if any)
7. Add a short index entry in `SKILL.md` pointing to the new extension file.
8. Update the extension row in `docs/extension-targets.md`:
   - status
   - source of truth
   - date updated
   - notes
9. Add notes to the backlog task explaining what evidence was captured and what
   remains unverified.
10. Check completed backlog acceptance criteria and Definition of Done items.
11. Only mark the backlog task `Done` when all acceptance criteria are checked.
    If serialized validation is still missing, leave the task `In Progress` or
    add a follow-up task and explain the split in the notes.
12. Commit the change with a clear message, for example:
   - `docs: add verified reference for Sticker extension`

## Extension Install And Validation

GDevelop extension references are most useful when they are backed by a saved
project JSON example, not only source metadata.

Observed GDevelop project patterns:

- Inline install: the project `game.json` contains full extension objects in the
  top-level `eventsFunctionsExtensions` array.
- Split install: the project `game.json` contains a reference entry such as:

```json
{
  "__REFERENCE_TO_SPLIT_OBJECT": true,
  "referenceTo": "/eventsFunctionsExtensions/arraytools"
}
```

and the matching extension file is stored at:

```text
eventsFunctionsExtensions/arraytools.json
```

For this skill's validation work, prefer the split install pattern. It keeps the
main project JSON smaller, reduces large read/write blocks, and makes extension
evidence easier to inspect independently.

For validation work:

1. Use `C:\GameDev\AI-Playground` as the approved disposable GDevelop
   validation project for this skill work unless the user names a different
   project.
2. Install the reviewed extension JSON as a split
   `eventsFunctionsExtensions/<extension>.json` file by default. Use inline
   installs only when there is a documented reason.
3. Add the smallest set of events needed to exercise representative actions,
   conditions, expressions, and behavior entries.
4. Save the project and capture exact serialized `type.value` and `parameters`
   arrays from the saved JSON.
5. Record the file path and line number in the capture note.
6. If a project runs in GDevelop or browser preview, record what was manually
   tested. If not, say that only static JSON validation was completed.

Important: keep GDevelop project JSON as UTF-8 without BOM. A BOM at the start
of `AI Playground.json` can make gdexporter report the project as corrupted or
malformed. Avoid PowerShell JSON reserialization for whole GDevelop project
files.

See `docs/extension-validation-automation.md` for the reusable validation loop
and helper script.

Do not edit production project files just to produce reference evidence unless
the user explicitly asks for that.

## Definition Of Done

An extension is `Verified` only when all checks pass:

- Every listed internal identifier is validated from editor/source.
- Parameter order is confirmed from real JSON or source metadata.
- Install shape is documented as inline, split `eventsFunctionsExtensions`, or
  both.
- Representative saved project JSON examples exist for the extension surface
  used by the reference.
- For events-based behaviors: modifiers are captured from `propertyDescriptors`
  and their runtime impact is checked in inline code (`_get...()` usage).
- The reference file includes at least one example.
- `SKILL.md` links to the extension reference.
- Target tracker row is updated with date and source notes.
- Backlog acceptance criteria and Definition of Done are updated, with final
  notes explaining any remaining gaps.

## GitHub Planning Use

Use `docs/extension-targets.md` as your planning board in GitHub:

- Convert `Backlog` or `Blocked` rows into GitHub issues.
- Include the extension name in the issue title.
- Link the issue URL back into the tracker notes.

This gives you one simple place to see:
- what is covered
- what is in progress
- what is still missing
