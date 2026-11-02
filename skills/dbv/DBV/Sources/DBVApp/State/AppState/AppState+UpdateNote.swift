// AppState+UpdateNote — one method, its own file. The single mutation path for human
// notes: edit in memory, then persist that ONE note's file immediately so nothing is
// lost on quit. Emptied notes have their file moved to the Trash. NEVER touches .jsonl.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import DBVCore

extension AppState {
    func updateNote(uuid: String, transform: (inout NoteRecord) -> Void) {
        guard let jsonlURL = notesJSONL else { return }
        var record = notes.record(for: uuid)
        if record.created.isEmpty { record.created = ISO8601DateFormatter().string(from: Date()) }
        transform(&record)
        if record.isEmpty {
            notes.records.removeValue(forKey: uuid)
            deleteNoteRecord(turnUUID: uuid, forJSONL: jsonlURL)
        } else {
            notes.records[uuid] = record
            saveNoteRecord(record, forJSONL: jsonlURL)
        }
    }
}
