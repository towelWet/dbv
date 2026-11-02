// AppState+TakePrefetchedJSONL — bytes read during the open event, keyed by basename.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension AppState {
    func takePrefetchedJSONL(for url: URL) -> String? {
        guard url.lastPathComponent == prefetchedJSONLName else { return nil }
        defer {
            prefetchedJSONLText = nil
            prefetchedJSONLName = nil
        }
        return prefetchedJSONLText
    }
}
