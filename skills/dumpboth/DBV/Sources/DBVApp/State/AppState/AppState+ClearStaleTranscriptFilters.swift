// AppState+ClearStaleTranscriptFilters — search/starred filters are per-transcript.
// Shared AppState + Finder `open -a` reuses the running app, so a partial search from
// another dump (e.g. "mmer" from "scammer") must not carry into the next jsonl.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension AppState {
    /// Drop view filters when the user opens a different jsonl (single-file or browser pick).
    func clearStaleTranscriptFilters(whenOpening url: URL) {
        if case .singleFile(let prior) = mode, prior.path == url.path { return }
        searchText = ""
        starredOnly = false
    }

    func clearStaleTranscriptFilters(whenSelecting jsonlURL: URL) {
        guard notesJSONL != jsonlURL else { return }
        searchText = ""
        starredOnly = false
    }
}
