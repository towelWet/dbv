// SerializeNoteRecord — write one NoteRecord as its own .toml file body. Note text uses
// a triple-quoted block so quotes/colons/newlines round-trip without escaping logic the
// subset reader lacks. Hand-editable on purpose.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func serializeNoteRecord(_ record: NoteRecord) -> String {
    var out = "# One human note for one turn of a Claude Code dump.\n"
    out += "# The sibling .jsonl transcript is canonical and is NEVER modified.\n"
    out += "turn_uuid = \"\(record.turnUUID)\"\n"
    if !record.created.isEmpty { out += "created = \"\(record.created)\"\n" }
    if record.starred { out += "starred = true\n" }
    if !record.text.isEmpty {
        out += "note = \"\"\"\n\(record.text)\n\"\"\"\n"
    }
    return out
}
