---
name: dbv
description: DBV (DumpBoth Viewer) SwiftUI app that renders Old Chats jsonl as a transcript. Rebuild, install, add jsonl format parsers by dropping a file, and verify Claude plus Cursor dumps. Use when the user says /dbv, DBV is blank, jsonl won't open, dumpboth cursor jsonl is empty in the viewer, or they need to rebuild DBV.app.
---

# /dbv — DumpBoth Viewer

Read-only jsonl transcript viewer. **Never rewrite a dump so DBV will open it.** If a dialect is blank, add a parser. Do not forge `type`/`uuid` onto Cursor lines.

## EXECUTE

```bash
~/.claude/skills/dbv/DBV/build.command
```

Installs `/Applications/DBV.app`, registers it as the default `.jsonl` handler. Generator runs first: glob `Formats/*/*Parser.swift` → `DiscoveredFormatParsers.generated.swift`.

## What it does (literally)

Renders a `.jsonl` as chat bubbles. Browser mode lists `~/Old Chats/` dump pairs. Finder-open is single-file, no sidebar.

**Implemented:** Claude Code jsonl (`type=user|assistant`) and Cursor agent jsonl (`role` + `message`, no top-level `type`).  
**Not implemented:** rewriting dumps; any dialect without a dropped parser (those stay blank).

## Add a format (zero edits to the loop)

1. Drop `DBV/Sources/DBVCore/Parsing/Formats/<name>/<Name>Parser.swift`
2. `struct <Name>Parser: JSONLLineParser` with `recognizes` + `parse`
3. Run `build.command` (glob picks it up)

Do **not** add the name to `ParseJSONLTranscript.swift`. That file only loops `discoveredFormatParsers()`.

## How to verify

```bash
~/.claude/skills/dbv/DBV/test.command
```

Do **not** run bare `swift build` / `swift test` in the DBV tree — that creates a multi‑GB `.build` on the internal disk. Always use `build.command` or `test.command`.

Known-good: `Tests/DBVCoreTests/Fixtures/claude-one-turn.jsonl` → 2 turns; `cursor-one-turn.jsonl` → 2 turns (status line skipped).

Against a real Cursor dump (read-only, do not edit the file):

```bash
open -a DBV "$HOME/Old Chats/oldchat4-mylabel-be34e436.jsonl"
```

Expect bubbles, not a white window. If still white: quit DBV (`killall DBV`) and reopen — a running instance keeps the old binary. Parser miss vs unreadable Finder URL now shows "No turns parsed" / "Could not read file" instead of a white pane. Do not patch the jsonl.

## Triggers

- `/dbv`
- DBV blank / Cursor dump won't render
- rebuild DBV after parser work
- add a new jsonl dialect

Publishing: upload this real skill folder, with private info removed. Never publish rewritten copy.
