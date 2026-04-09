# Extension Support Workflow

This workflow helps you add GDevelop extension support in small, safe steps
without guessing internal names.

## Goal

For each extension target, we want:

1. A tracked status in `docs/extension-targets.md`.
2. A verified capture record (from editor/source) using the template.
3. A reference doc added under `references/extensions/`.
4. `SKILL.md` and this repo README updated so the skill can route correctly.

## Status Stages

Use exactly these statuses in `docs/extension-targets.md`:

- `Backlog`: not started yet.
- `Capturing`: collecting verified actions/conditions/expressions.
- `Drafted`: reference file exists but not reviewed.
- `Verified`: reviewed and ready for regular use.
- `Blocked`: waiting on missing source examples or unresolved naming.

## Step-By-Step Process

1. Pick the next extension from `docs/extension-targets.md`.
2. Create a new capture file using `docs/extension-capture-template.md`.
3. Fill the capture file only with verified information from:
   - GDevelop event editor labels and generated JSON, or
   - GDevelop source metadata for the extension.
4. Create `references/extensions/<extension-name>.md` with:
   - internal identifiers (`type.value`)
   - parameter order
   - behavior modifier properties (when the extension defines a behavior)
   - examples
   - deprecations or gotchas (if any)
5. Add a short index entry in `SKILL.md` pointing to the new extension file.
6. Update the extension row in `docs/extension-targets.md`:
   - status
   - source of truth
   - date updated
   - notes
7. Commit the change with a clear message, for example:
   - `docs: add verified reference for Sticker extension`

## Definition Of Done

An extension is `Verified` only when all checks pass:

- Every listed internal identifier is validated from editor/source.
- Parameter order is confirmed from real JSON or source metadata.
- For events-based behaviors: modifiers are captured from `propertyDescriptors`
  and their runtime impact is checked in inline code (`_get...()` usage).
- The reference file includes at least one example.
- `SKILL.md` links to the extension reference.
- Target tracker row is updated with date and source notes.

## GitHub Planning Use

Use `docs/extension-targets.md` as your planning board in GitHub:

- Convert `Backlog` or `Blocked` rows into GitHub issues.
- Include the extension name in the issue title.
- Link the issue URL back into the tracker notes.

This gives you one simple place to see:
- what is covered
- what is in progress
- what is still missing
