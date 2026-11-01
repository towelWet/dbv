// ParseNoteRecord — read one note file back into a NoteRecord. Flat keys (no [section])
// because each file holds exactly one note, so there is nothing to disambiguate.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func parseNoteRecord(_ text: String, turnUUID: String) -> NoteRecord {
    var reader = TOMLSubsetReader()
    text.split(separator: "\n", omittingEmptySubsequences: false).forEach { reader.consume(String($0)) }
    let values = reader.sections[""] ?? [:]      // "" is the implicit top-level section
    return NoteRecord(
        turnUUID: turnUUID,
        text: values["note"] ?? "",
        starred: (values["starred"] ?? "") == "true",
        created: values["created"] ?? ""
    )
}
