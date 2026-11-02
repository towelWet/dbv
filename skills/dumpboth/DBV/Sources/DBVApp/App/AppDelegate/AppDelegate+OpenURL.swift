// AppDelegate+OpenURL — sync prepare + prefetch; MainActor adopt when state exists.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension AppDelegate {
    func openURL(_ url: URL) {
        let now = Date()
        if url.path == lastOpenPath,
           now.timeIntervalSince(lastOpenTime) < 0.5 { return }
        lastOpenPath = url.path
        lastOpenTime = now
        _ = url.startAccessingSecurityScopedResource()
        queuePreparedDocument(prepareDocumentOpen(url))
    }

    @MainActor
    func adoptPendingIfAttached() {
        guard let prep = pendingDocumentOpen, let state else { return }
        pendingDocumentOpen = nil
        state.adoptDocumentOpen(prep)
    }
}
