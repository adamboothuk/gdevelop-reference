# GDevelop Object Definitions JSON Reference

Authoritative reference for creating or editing object definitions in GDevelop
project and scene JSON files.

## Scope

Use this file when editing:

- `game.json` -> `objects` (project/global objects)
- `layouts/<scene>.json` -> `objects` (scene-local objects)

This file is for object definitions, not object placement. For placement in a
scene, use `references/instances.md`.

Primary verified sources used for this reference:

- `C:/GameDev/Dark-Ship-Codex/game.json`
- `C:/GameDev/Dark-Ship-Codex/layouts/main.json`

## Container Structure

Both project-level and scene-level object lists use an array under `objects`:

```json
{
  "objects": [
    {
      "name": "Player",
      "type": "Sprite"
    }
  ]
}
```

## Baseline Object Fields

Across observed object types, these fields are common and should be preserved:

- `name` (string): object identifier used by events and instances
- `type` (string): object type identifier (for example `Sprite`)
- `variables` (array): object variable definitions
- `effects` (array): object effects
- `behaviors` (array): behavior definitions
- `assetStoreId` (string): usually empty for custom objects

Some objects also include `persistentUuid`. Keep it when present.

## Type Templates (Verified)

### Sprite (`type: "Sprite"`)

Minimum practical template:

```json
{
  "adaptCollisionMaskAutomatically": true,
  "assetStoreId": "",
  "name": "NewSprite",
  "type": "Sprite",
  "updateIfNotVisible": false,
  "variables": [],
  "effects": [],
  "behaviors": [],
  "animations": [
    {
      "name": "",
      "useMultipleDirections": false,
      "directions": [
        {
          "looping": false,
          "timeBetweenFrames": 0.08,
          "sprites": [
            {
              "hasCustomCollisionMask": true,
              "image": "DebugMarker.png",
              "points": [],
              "originPoint": { "name": "origine", "x": 0, "y": 0 },
              "centerPoint": { "automatic": true, "name": "centre", "x": 0, "y": 0 },
              "customCollisionMask": [[
                { "x": 0, "y": 0 },
                { "x": 32, "y": 0 },
                { "x": 32, "y": 32 },
                { "x": 0, "y": 32 }
              ]]
            }
          ]
        }
      ]
    }
  ]
}
```

Resource rule: `sprites[].image` must match an image resource `name` in
`game.json -> resources.resources`.

### Text (`type: "TextObject::Text"`)

Minimum practical template:

```json
{
  "assetStoreId": "",
  "bold": false,
  "italic": false,
  "name": "NewText",
  "smoothed": true,
  "type": "TextObject::Text",
  "underlined": false,
  "variables": [],
  "effects": [],
  "behaviors": [],
  "string": "Hello",
  "font": "assets\\font\\Jersey25-Regular.ttf",
  "textAlignment": "center",
  "characterSize": 32,
  "color": { "r": 255, "g": 255, "b": 255 },
  "content": {
    "bold": false,
    "isOutlineEnabled": false,
    "isShadowEnabled": false,
    "italic": false,
    "outlineColor": "255;255;255",
    "outlineThickness": 2,
    "shadowAngle": 90,
    "shadowBlurRadius": 2,
    "shadowColor": "0;0;0",
    "shadowDistance": 4,
    "shadowOpacity": 127,
    "smoothed": true,
    "underlined": false,
    "text": "Hello",
    "font": "assets\\font\\Jersey25-Regular.ttf",
    "textAlignment": "center",
    "verticalTextAlignment": "center",
    "characterSize": 32,
    "lineHeight": 0,
    "color": "255;255;255"
  }
}
```

Resource rule: `font` must match a font resource `name` in
`game.json -> resources.resources`.

### Panel Sprite (`type: "PanelSpriteObject::PanelSprite"`)

Observed object-specific fields:

- `texture`
- `width`, `height`
- `leftMargin`, `rightMargin`, `topMargin`, `bottomMargin`
- `tiled`

### Panel Sprite Button (`type: "PanelSpriteButton::PanelSpriteButton"`)

Observed object-specific fields:

- `variant`
- `content` (padding and label defaults)

## Object Creation Workflow (Safe)

1. Choose the target container: project `objects` or scene `objects`.
2. Choose a verified template matching your desired `type`.
3. Set a unique `name`.
4. Verify resource references used by the object exist in `resources.resources`.
5. Keep `variables`, `effects`, and `behaviors` arrays present.
6. If cloning an existing object, preserve unknown fields unless intentionally changing them.

## Safety Rules

- Do not guess object-type-specific fields for unverified types.
- If a type is missing from this reference, capture one object of that type from
  GDevelop editor output first, then extend this file.
- Keep object `name` unique within the target container.
- Use `references/instances.md` separately when placing the object in scenes.
