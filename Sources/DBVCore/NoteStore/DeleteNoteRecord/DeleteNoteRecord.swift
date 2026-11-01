// DeleteNoteRecord — remove one note file when its note is cleared.
// Uses FileManager.trashItem, NOT removeItem: deletions go to the Trash so a note is
// always recoverable (matches the standing "mv to Trash, never rm" safety rule, and is
// the correct macOS behaviour for user-authored content anyway).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

@discardableResult
public func deleteNoteRecord(turnUUID: String, forJSONL jsonlURL: URL) -> Bool {
    let file = NoteFilePath.file(forJSONL: jsonlURL, turnUUID: turnUUID)
    guard file.pathExtension == "toml",
          FileManager.default.fileExists(atPath: file.path) else { return false }
    return (try? FileManager.default.trashItem(at: file, resultingItemURL: nil)) != nil
}
