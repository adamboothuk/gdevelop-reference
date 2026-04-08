# Per-Run Debug Logging Pattern (GDevelop)

## Purpose
Provide a reusable logging mechanism for playtest/debug sessions where events write short messages to a variable, and a central event group persists those messages to a run-specific log file.

## Design Goals
- Project-agnostic: no hardcoded scene names, object names, or state machine names.
- Scene-agnostic: can live in a shared external event, or in any scene.
- Low friction: any event can log by setting one variable.
- Traceable: one file per run, not one rolling file.

## Core Contract
1. First log write in a run creates a unique run id and file path.
2. All later writes in the same run append to that same file.
3. Log files are written under `documents/logs/`.
4. Source control excludes generated log files.

## Required Variables
Use either scene or global scope (choose once and stay consistent).

- `Debug_Log_String` (string): message requested by gameplay/debug logic.
- `Debug_Log_FilePath` (string): current run log file path.
- `Debug_Log_RunId` (string): unique run identifier.

Optional helper variables:
- `Debug_Log_Timestamp` (string): formatted time string.
- `Debug_Log_HeaderWritten` (boolean/number): guard for optional header.

## Event Group Blueprint
Create one central event group (example name: `Debug_Logging`).

### A) Reset on scene/startup
On scene start (or run start), clear:
- `Debug_Log_String`
- `Debug_Log_FilePath`
- `Debug_Log_RunId`

### B) Initialize log file on first use
Conditions:
- `Debug_Log_String` is not empty
- `Debug_Log_FilePath` is empty

Actions:
- Build a run id from date/time plus random suffix.
- Set path: `documents/logs/run_<runId>.txt`.
- Optionally write a header line (`RunId`, date/time, scene).

### C) Append message and clear buffer
Condition:
- `Debug_Log_String` is not empty

Actions:
- Build line: `[timestamp] <message>`.
- Append line to file (or read+concat+write if append is unavailable).
- Clear `Debug_Log_String`.

## Usage Pattern
Any event can write a log line by setting:

- `Debug_Log_String = "your message"`

Prefer short, searchable prefixes, for example:
- `[ROOM] Enter pause`
- `[CAMERA] Snap to player`
- `[HAZARD] Activated`

## Storage and VCS Rules
Create folder and keep placeholder:
- `documents/logs/.gitkeep`

Ignore generated logs:
- `documents/logs/*`
- `!documents/logs/.gitkeep`

## Scope Guidance
- Use scene variables when logs should reset per scene run.
- Use global variables when multiple scenes should write into one continuous run log.

## Reliability Notes
- Keep all file I/O in one event group to avoid duplicate writes.
- Always clear `Debug_Log_String` after writing.
- Avoid per-frame spam unless intentionally profiling.
- For high-frequency logs, gate writes behind a debug flag or sampled interval.

## AI Porting Notes
When applying this pattern to a different project, an AI should:
1. Confirm whether variables should be scene or global.
2. Add missing variables explicitly before referencing them.
3. Create `documents/logs/` and update ignore rules.
4. Keep the same variable names unless team conventions require renaming.
5. Ensure only one logging event group performs file writes.
