# GDevelop Reference Skill for Codex

This repository remains available as a standalone sharing repo for the GDevelop reference skill.

The same skill is also maintained in the broader skills mono-repo:

https://github.com/adamboothuk/skills/tree/main/skills/gdevelop-reference

---

# GDevelop Reference Skill for Codex

This repository contains a Codex skill that provides **verified reference data**
for GDevelop scene JSON work.

It is designed to prevent guessing when editing:
- action/condition/expression identifiers
- parameter order and formatting
- scene/external layout `instances` arrays

## What This Skill Is For

Use this skill when working on GDevelop JSON and you need accurate internal names
or schema fields for:
- events (conditions/actions/expressions)
- object placement and instance data
- timers, variables, forces, layers, and capability-scoped instructions

## Core Principle

Never guess identifiers or instance fields.

If something is not present in this skill's references, treat it as unknown and
ask for a verified example from the GDevelop editor or source.

## Repository Structure

- `SKILL.md`  
  Main skill instructions, safety rules, event JSON structure, and category index.
- `references/`  
  Detailed reference docs by category (instances, scene, variables, time, etc.).
- `references/behaviors.md`  
  Behavior attachment reference: verified behavior `type` strings, JSON shape, and compatibility/caution tags.
- `scripts/validate-instances.ps1`  
  Validation helper for scene/external-layout instance JSON edits.
- `docs/extension-support-workflow.md`  
  Repeatable process for adding extension coverage safely over time.
- `docs/extension-targets.md`  
  Living backlog/status tracker for extension coverage targets.
- `docs/extension-capture-template.md`  
  Fill-in template for collecting verified extension metadata before writing references.

## Validation Helper

Example usage:

```powershell
.\scripts\validate-instances.ps1 -ScenePath .\path\to\layout.json
```

With optional project context and fix suggestions:

```powershell
.\scripts\validate-instances.ps1 -ScenePath .\path\to\layout.json -ProjectPath .\path\to\game.json -Mode suggest-fixes
```

## Limitations and Observations

- You will need to be working on GDevelop desktop with a locally saved project to get access to the JSON files
- Version control seems to work fine in this environment so use it. You are editing the project files directly so the client might not save you
- After your AI tool has made an update you will need to reload the project. Use File -> Open Recent and select your current project to force a reload. Changes will then be visible and available in preview
- There is no way for an AI tool to see the console log. This can be worked around by allowing the AI to create it's own logging system. Instruction for this is given below in ## Custom Console Logging
- This skill now includes initial coverage for creating new objects. Use `references/objects.md` and favor verified type templates over ad-hoc fields
- This skill works best when there is an existing project to work within. It has not been tested on setting up a completely new project. Try it and report back if you are brave
- It is often useful to support the AI with examples. Consider creating a test scene where you can create events or objects and then copy and paste the created JSON into the prompt as a reference
- Work in small steps. Plan, build, test. Set the scope tightly and watch for the AI wandering off. The ability to architect a game is not confirmed


## Custom Console Logging

To work around the lack of console log access you might consider creating a custom logging system which outputs to plain text files. Here is a summary of the system created by Codex which worked for me

- Per-run debug logging pattern: [references/debug-logging-pattern.md](references/debug-logging-pattern.md)
- Quick setup checklist: [references/debug-logging-checklist.md](references/debug-logging-checklist.md)

<!-- Add your custom notes below -->

## Extension Coverage Workflow

If you want to add support for Common Extension features (for example `Sticker`,
`Smooth camera`, `ArrayTools`) over time, use:

- [Workflow Guide](docs/extension-support-workflow.md)
- [Target Tracker](docs/extension-targets.md)
- [Capture Template](docs/extension-capture-template.md)
