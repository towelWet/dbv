// LoadTranscript — bookmark, prefetch, then loadJSONLTranscript (DBVCore tests path).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import DBVCore

@MainActor
func loadTranscript(url: URL, state: AppState) async -> JSONLLoadResult {
    if let text = state.takePrefetchedJSONL(for: url) {
        return jsonlLoadResult(from: text)
    }
    if state.fileScopeURL == nil { state.beginFileSecurityScope(url) }
    return loadJSONLTranscript(url: url)
}
