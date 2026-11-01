// AppState+LoadNotes — one method, its own file. Loads the human note layer for a
// transcript when it's opened/selected. Reads only; see AppState+UpdateNote for writes.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import DBVCore

extension AppState {
    func loadNotesIfNeeded(for jsonlURL: URL) {
        guard notesJSONL != jsonlURL else { return }   // already loaded for this file
        clearStaleTranscriptFilters(whenSelecting: jsonlURL)
        notes = loadNotes(forJSONL: jsonlURL)
        notesJSONL = jsonlURL
    }
}
