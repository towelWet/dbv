// RunTranscriptLoad — load transcript bytes (panel grant handled by TranscriptView).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import DBVCore

@MainActor
func runTranscriptLoad(state: AppState, jsonlURL: URL) async -> JSONLLoadResult {
    state.loadNotesIfNeeded(for: jsonlURL)
    return await loadTranscript(url: jsonlURL, state: state)
}
