// SaveNoteRecord — write ONE note to its own file, creating the dump's folder on demand.
// SAFETY INVARIANT: this is the only write path in DBV and it targets db/<dump>/<uuid>.toml
// exclusively. Nothing here ever opens a .jsonl for writing — that file is canonical.
// The .toml guard makes a path bug incapable of clobbering a transcript.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

@discardableResult
public func saveNoteRecord(_ record: NoteRecord, forJSONL jsonlURL: URL) -> Bool {
    let folder = DumpFolderPath.folder(forJSONL: jsonlURL)
    let file = NoteFilePath.file(forJSONL: jsonlURL, turnUUID: record.turnUUID)
    guard file.pathExtension == "toml" else { return false }
    do {
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        try serializeNoteRecord(record).write(to: file, atomically: true, encoding: .utf8)
        return true
    } catch {
        return false
    }
}
