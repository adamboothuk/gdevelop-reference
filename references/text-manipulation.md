# GDevelop Text Manipulation Reference

Extracted from `StringInstructionsExtension.cpp`. Extension ID: `BuiltinStringInstructions`.

This extension provides string and numeric expressions only. It does not add actions or conditions.

## Open This File When

- the task needs built-in string expression names
- the task manipulates case, substrings, character lookup, search, replace, or repeat
- the task needs the exact argument order for GDevelop text functions

## String Expressions

| Type | Name | Parameters |
|------|------|------------|
| STR_EXPRESSION | `NewLine` | none |
| STR_EXPRESSION | `FromCodePoint` | codePoint |
| STR_EXPRESSION | `ToUpperCase` | text |
| STR_EXPRESSION | `ToLowerCase` | text |
| STR_EXPRESSION | `SubStr` | text, startIndex, length |
| STR_EXPRESSION | `StrAt` | text, index |
| STR_EXPRESSION | `StrRepeat` | text, repeatCount |
| STR_EXPRESSION | `StrReplaceOne` | text, findText, replacement |
| STR_EXPRESSION | `StrReplaceAll` | text, findText, replacement |

## Numeric Search And Length Expressions

| Type | Name | Parameters |
|------|------|------------|
| EXPRESSION | `StrLength` | text |
| EXPRESSION | `StrFind` | text, searchText |
| EXPRESSION | `StrFindLast` | text, searchText |
| EXPRESSION | `StrFindFrom` | text, searchText, startIndex |
| EXPRESSION | `StrFindLastFrom` | text, searchText, fromIndex |

Deprecated hidden aliases:

| Type | Name | Parameters |
|------|------|------------|
| EXPRESSION | `StrRFind` | text, searchText |
| EXPRESSION | `StrRFindFrom` | text, searchText, fromIndex |

Notes:

- `StrFind` and `StrFindFrom` return the position of the first match or `-1` if not found.
- `StrFindLast` and `StrFindLastFrom` return the position of the last match, counted from the beginning of the string, or `-1`.
- Indexing is zero-based in functions like `SubStr` and `StrAt`.

## Example Usage

```text
ToUpperCase(VariableString(PlayerName))
SubStr("Level_Complete", 0, 5)
StrFind("banana", "na")
StrReplaceAll("1-2-3", "-", ":")
NewLine()
```
