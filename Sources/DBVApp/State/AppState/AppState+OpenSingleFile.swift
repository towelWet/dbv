// AppState+OpenSingleFile — capture LS grant synchronously (see PrepareDocumentOpen).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension AppState {
    func openSingleFile(_ url: URL) {
        adoptDocumentOpen(prepareDocumentOpen(url))
    }
}
