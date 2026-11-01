// AppDelegate+AdoptPending — MainActor adopt when state exists.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension AppDelegate {
    @MainActor
    func adoptPendingIfAttached() {
        guard let prep = pendingDocumentOpen, let state else { return }
        pendingDocumentOpen = nil
        state.adoptDocumentOpen(prep)
    }
}
