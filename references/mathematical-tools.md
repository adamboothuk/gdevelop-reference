# GDevelop Mathematical Tools Reference

Extracted from `MathematicalToolsExtension.cpp`. Extension ID: `BuiltinMathematicalTools`.

This extension provides expressions only. It does not add actions or conditions.

## Open This File When

- the task needs built-in math expression names
- the task uses random values, interpolation, trigonometry, logarithms, roots, or rounding
- the task needs the exact argument order for GDevelop math functions

## Random And Range Expressions

| Expression | Parameters |
|------------|------------|
| `Random` | max |
| `RandomInRange` | min, max |
| `RandomFloat` | max |
| `RandomFloatInRange` | min, max |
| `RandomWithStep` | min, max, step |

## Remapping, Distance, And Angle Helpers

| Expression | Parameters |
|------------|------------|
| `normalize` | value, min, max |
| `clamp` | value, min, max |
| `AngleDifference` | firstAngleDeg, secondAngleDeg |
| `AngleBetweenPositions` | x1, y1, x2, y2 |
| `DistanceBetweenPositions` | x1, y1, x2, y2 |
| `lerp` | a, b, x |
| `lerpAngle` | startAngleDeg, endAngleDeg, t |
| `XFromAngleAndDistance` | angleDeg, distance |
| `YFromAngleAndDistance` | angleDeg, distance |

## Basic Math And Modifiers

| Expression | Parameters |
|------------|------------|
| `mod` | x, y |
| `min` | a, b |
| `max` | a, b |
| `abs` | value |
| `sign` | value |
| `pow` | number, exponent |
| `nthroot` | number, n |
| `sqrt` | value |
| `cbrt` | value |
| `exp` | value |
| `trunc` | value |

## Rounding

| Expression | Parameters |
|------------|------------|
| `ceil` | value |
| `ceilTo` | value, decimalPlaces(optional) |
| `floor` | value |
| `floorTo` | value, decimalPlaces(optional) |
| `round` | value |
| `roundTo` | value, decimalPlaces(optional) |

Hidden aliases:

| Expression | Parameters |
|------------|------------|
| `int` | value |
| `rint` | value |

## Trigonometry

These trigonometric expressions use radians unless the name or source text says otherwise.
Use `ToRad` and `ToDeg` from `references/scene-logic.md` when conversion is needed.

| Expression | Parameters |
|------------|------------|
| `sin` | value |
| `cos` | value |
| `tan` | value |
| `asin` | value |
| `acos` | value |
| `atan` | value |
| `atan2` | y, x |
| `cot` | value |
| `sec` | value |
| `csc` | value |

## Hyperbolic Functions

| Expression | Parameters |
|------------|------------|
| `sinh` | value |
| `cosh` | value |
| `tanh` | value |
| `asinh` | value |
| `acosh` | value |
| `atanh` | value |

## Logarithms And Constants

| Expression | Parameters |
|------------|------------|
| `log` | value |
| `log2` | value |
| `log10` | value |
| `Pi` | none |

Hidden alias:

| Expression | Parameters |
|------------|------------|
| `ln` | value |

## Example Usage

```text
RandomInRange(0, 10)
clamp(Variable(PlayerSpeed), 0, 400)
lerpAngle(Variable(CurrentAngle), 180, 0.1)
DistanceBetweenPositions(Player.X(), Player.Y(), Target.X(), Target.Y())
```
