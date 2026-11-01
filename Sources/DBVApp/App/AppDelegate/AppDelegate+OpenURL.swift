// AppDelegate+OpenURL — sync prepare + prefetch; repeated open of same path is ignored.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension AppDelegate {
    func openURL(_ url: URL) {
        let now = Date()
        if url.path == lastOpenPath,
           now.timeIntervalSince(lastOpenTime) < 0.5 { return }   // macOS can deliver one open twice
        lastOpenPath = url.path
        lastOpenTime = now
        _ = url.startAccessingSecurityScopedResource()
        queuePreparedDocument(prepareDocumentOpen(url))
    }
}
