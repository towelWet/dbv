// LoadNotes — read every note file in a dump's folder into a NoteBook. A missing folder
// is normal (no notes yet) and yields an empty book, never an error.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func loadNotes(forJSONL jsonlURL: URL) -> NoteBook {
    let folder = DumpFolderPath.folder(forJSONL: jsonlURL)
    guard let entries = try? FileManager.default.contentsOfDirectory(
        at: folder, includingPropertiesForKeys: nil) else { return NoteBook() }

    var records: [String: NoteRecord] = [:]
    for url in entries where url.pathExtension == "toml" {
        let uuid = url.deletingPathExtension().lastPathComponent
        guard let text = try? String(contentsOf: url, encoding: .utf8) else { continue }
        let record = parseNoteRecord(text, turnUUID: uuid)
        if !record.isEmpty { records[uuid] = record }
    }
    return NoteBook(records: records)
}
