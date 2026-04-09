# GDevelop Object Definitions JSON Reference

Authoritative reference for creating or editing object definitions in GDevelop
project and scene JSON files.

## Scope

Use this file when editing:

- `game.json` -> `objects` (project/global objects, shared across scenes)
- `layouts/<scene>.json` -> `objects` (scene-local objects, preferred default)

This file is for object definitions, not object placement. For placement in a
scene, use `references/instances.md`.

Default scope rule:

- Prefer scene-local objects first.
- Use global objects only when an object is intentionally reused across
  multiple scenes.
- Avoid promoting to global too early, because moving global back to scene-local
  is not supported directly in GDevelop.

Primary verified sources used for this reference:

- `C:/GameDev/Dark-Ship-Codex/game.json`
- `C:/GameDev/Dark-Ship-Codex/layouts/main.json`
- `C:/GameDev/AI-Playground/AI Playground.json` (Text object validation capture, 2026-04-09)
- `C:/GameDev/AI-Playground/AI Playground.json` (Tilemap validation capture, 2026-04-09)

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

Validation Notes (2026-04-09 AI-Playground capture):

- Confirmed serialized keys in a scene-level `TextObject::Text` object:
  `name`, `type`, `variables`, `behaviors`, `string`, `font`,
  `characterSize`, `bold`, `italic`, `underlined`, `smoothed`, `color`.
- Not present in this capture (treat as optional/variant):
  `assetStoreId`, `effects`, `textAlignment`, `content`.

Resource rule: `font` must match a font resource `name` in
`game.json -> resources.resources`.

### Panel Sprite (`type: "PanelSpriteObject::PanelSprite"`)

Observed object-specific fields:

- `texture`
- `width`, `height`
- `leftMargin`, `rightMargin`, `topMargin`, `bottomMargin`
- `tiled`

Panel rendering rule:

- Set `tiled: true` when the border/center regions should repeat instead of stretch.
- Use this for repeating or patterned panel art to avoid visual distortion.

### Panel Sprite Button (`type: "PanelSpriteButton::PanelSpriteButton"`)

Observed object-specific fields:

- `variant`
- `content` (padding and label defaults)

### Tilemap (`type: "TileMap::SimpleTileMap"`)

Observed object-specific fields:

- `content.atlasImage`
- `content.rowCount`
- `content.columnCount`
- `content.tileSize`
- `content.tilesWithHitBox`

Verified object template (scene-level):

```json
{
  "assetStoreId": "",
  "name": "TestTileMap",
  "type": "TileMap::SimpleTileMap",
  "variables": [],
  "effects": [],
  "behaviors": [],
  "content": {
    "atlasImage": "asset_store/TileMap - General - Mid - 64px.png",
    "rowCount": 4,
    "columnCount": 16,
    "tileSize": 64,
    "tilesWithHitBox": ""
  }
}
```

Verified instance linkage rule:

- Tile layout is stored per instance in `stringProperties` with
  `name: "tilemap"` and a JSON-string value.
- Example 1x1 instance payload:
  `{"tileWidth":64,"tileHeight":64,"dimX":1,"dimY":1,"layers":[{"id":0,"alpha":1,"tiles":[[1]]}]}`

Caution note:

- Treat Tilemap as editor-managed content. The Tilemap Painter panel can rewrite
  serialized map payloads, so manual JSON edits should be kept minimal and then
  validated in GDevelop before wider reuse.
- Do not flatten object tilemap fields at the root level; keep them under
  `content` for `TileMap::SimpleTileMap`.

## Object Creation Workflow (Safe)

1. Choose the target container: project `objects` or scene `objects`.
2. Default to scene `objects` unless cross-scene reuse is required.
3. Choose a verified template matching your desired `type`.
4. Set a unique `name`.
5. Verify resource references used by the object exist in `resources.resources`.
6. Keep `variables`, `effects`, and `behaviors` arrays present.
7. If cloning an existing object, preserve unknown fields unless intentionally changing them.

## Safety Rules

- Do not guess object-type-specific fields for unverified types.
- If a type is missing from this reference, capture one object of that type from
  GDevelop editor output first, then extend this file.
- Keep object `name` unique within the target container.
- Use `references/instances.md` separately when placing the object in scenes.

