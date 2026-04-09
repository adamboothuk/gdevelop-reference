# GDevelop Object Behaviors JSON Reference

Authoritative reference for adding behaviors to object definitions in GDevelop
JSON without using the editor UI.

## Scope

Use this file when editing:

- `layouts/<scene>.json` object behavior arrays (`objects[].behaviors`)
- scene behavior shared data (`behaviorsSharedData`)
- behavior type identifiers needed for JSON editing

This file covers behavior attachment metadata, not full action/condition catalogs
for each behavior.

## Critical Rule

Never guess a behavior `type` string.

If behavior type, behavior name, compatibility, or caution status is unknown:

1. Say coverage is incomplete.
2. Ask for a verified capture from GDevelop editor, or
3. Verify from trusted source files before writing JSON.

## Required JSON Shape

When adding a behavior to an object in a scene, add both:

1. Object behavior entry:

```json
{
  "name": "Tween",
  "type": "Tween::TweenBehavior"
}
```

2. Matching scene shared-data entry:

```json
{
  "name": "Tween",
  "type": "Tween::TweenBehavior"
}
```

If `behaviorsSharedData` is missing the behavior type, GDevelop can show missing
or broken behavior metadata.

## Compatibility And Caution Tags

Use these two tags for each behavior entry in this reference:

- `Compatibility`:
  - `VerifiedWithSprite`: confirmed by direct project test on a Sprite object
  - `KnownInSource`: present in trusted source/capture, not yet sprite-tested
  - `PotentiallyObjectSpecific`: likely restricted by object capabilities
- `Caution`:
  - `Normal`
  - `Experimental`
  - `Deprecated`
  - `Unknown`

If GDevelop editor shows `Incompatible with the object`, treat it as
`PotentiallyObjectSpecific` and do not force-apply blindly.

If GDevelop editor shows `Experimental`, keep `Caution=Experimental`.

## Starter Behavior Catalog (Verified Types)

| Behavior | JSON `type` | Recommended `name` | Compatibility | Caution | Evidence |
|---|---|---|---|---|---|
| Tween | `Tween::TweenBehavior` | `Tween` | `VerifiedWithSprite` | `Normal` | `Dark-Ship-Codex` captures + `TweenBehavior/JsExtension.js` |
| Draggable | `DraggableBehavior::Draggable` | `Draggable` | `VerifiedWithSprite` | `Normal` | `GDJS tests` + `DraggableBehavior/Extension.cpp` |
| Anchor | `AnchorBehavior::AnchorBehavior` | `Anchor` | `KnownInSource` | `Normal` | `AnchorBehavior/Extension.cpp` + `Dark-Ship` captures |
| Destroy Outside | `DestroyOutsideBehavior::DestroyOutside` | `DestroyOutside` | `KnownInSource` | `Normal` | `DestroyOutsideBehavior/Extension.cpp` + `GDJS tests` |
| Top-Down Movement | `TopDownMovementBehavior::TopDownMovementBehavior` | `TopDownMovement` | `KnownInSource` | `Normal` | `TopDownMovementBehavior/Extension.cpp` + `GDJS tests` |
| Platformer Character | `PlatformBehavior::PlatformerObjectBehavior` | `PlatformerObject` | `KnownInSource` | `Normal` | `PlatformBehavior/Extension.cpp` + `Dark-Ship` captures |
| Platform (Obstacle) | `PlatformBehavior::PlatformBehavior` | `PlatformBehavior` | `KnownInSource` | `Normal` | `PlatformBehavior/Extension.cpp` + `Dark-Ship` captures |
| Pathfinding Agent | `PathfindingBehavior::PathfindingBehavior` | `Pathfinding` | `KnownInSource` | `Normal` | `PathfindingBehavior/Extension.cpp` + `Dark-Ship` captures |
| Pathfinding Obstacle | `PathfindingBehavior::PathfindingObstacleBehavior` | `PathfindingObstacle` | `KnownInSource` | `Normal` | `PathfindingBehavior/Extension.cpp` + `Dark-Ship` captures |
| Physics Engine (legacy) | `PhysicsBehavior::PhysicsBehavior` | `Physics` | `KnownInSource` | `Deprecated` | `PhysicsBehavior/Extension.cpp` marks old engine |

## Safe Workflow

1. Choose target object and scene.
2. Pick behavior entry from the catalog above.
3. Add behavior object to `objects[].behaviors` if missing.
4. Add same `name`/`type` to scene `behaviorsSharedData` if missing.
5. Reload project in GDevelop.
6. Confirm behavior appears and does not show missing/incompatible errors.
7. If incompatible/experimental flags appear, record them before broad reuse.

## Capture Backlog Rules

When a new behavior is requested:

1. Verify `type` from trusted source.
2. Try in Playground on target object type (for example Sprite).
3. Record outcome as `Compatibility` and `Caution`.
4. Add it to this file only after verification.
