# Debug Logging Quick Checklist (GDevelop)

Use this checklist to add per-run debug logging to any GDevelop project.

## Setup
1. Choose variable scope: `scene` or `global`.
2. Define variables:
   - `Debug_Log_String` (string)
   - `Debug_Log_FilePath` (string)
   - `Debug_Log_RunId` (string)
3. Add folder `documents/logs/` with `.gitkeep`.
4. Add ignore rules:
   - `documents/logs/*`
   - `!documents/logs/.gitkeep`

## Event Group
5. Create one logging event group (single writer).
6. On startup, reset the three variables to empty.
7. If `Debug_Log_String` is set and `Debug_Log_FilePath` is empty:
   - create run id
   - set filepath to `documents/logs/run_<runId>.txt`
8. If `Debug_Log_String` is set:
   - prepend timestamp
   - append/write to file
   - clear `Debug_Log_String`

## Usage
9. From any event, log by setting `Debug_Log_String` to a concise message.
10. Use searchable tags (for example `[ROOM]`, `[PLAYER]`, `[CAMERA]`, `[HAZARD]`).

## Validation
11. Run preview twice and confirm two separate log files are created.
12. Confirm each run file contains only that run's messages.

## Common Mistakes
- Referencing variables that were never declared.
- Writing from multiple event groups (duplicate or out-of-order lines).
- Forgetting to clear `Debug_Log_String` after write.
- Committing generated log files.
