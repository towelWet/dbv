// AppState+ClearStaleFiltersWhenSelecting — search filters do not carry to next browser pick.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension AppState {
    func clearStaleTranscriptFilters(whenSelecting jsonlURL: URL) {
        guard notesJSONL != jsonlURL else { return }
        searchText = ""
        starredOnly = false
    }
}
