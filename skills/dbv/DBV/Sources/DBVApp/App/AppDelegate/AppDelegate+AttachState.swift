// AppDelegate+AttachState — Apple Event open + queued prep before browser mode.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension AppDelegate {
    @MainActor
    func attach(state: AppState) {
        self.state = state
        adoptPendingIfAttached()
        if pendingDocumentOpen == nil {
            for url in openedDocumentsFromAppleEvent() + openedDocumentsFromArguments() {
                openURL(url)
                break
            }
        }
    }
}
