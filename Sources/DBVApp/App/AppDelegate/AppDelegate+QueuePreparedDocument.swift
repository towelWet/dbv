// AppDelegate+QueuePreparedDocument — hold prepared document until MainActor can adopt it.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension AppDelegate {
    func queuePreparedDocument(_ prep: DocumentOpenPrepared) {
        pendingDocumentOpen = prep
        Task { @MainActor in self.adoptPendingIfAttached() }
    }
}
