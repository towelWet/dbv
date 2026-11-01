// AppState+FileSecurityScope — scope on opener URL, then resolved fallback.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension AppState {
    func beginFileSecurityScope(_ url: URL) {
        endFileSecurityScope()
        if url.startAccessingSecurityScopedResource() {
            fileScopeActive = true
            fileScopeURL = url
            return
        }
        let resolved = url.resolvingSymlinksInPath()
        fileScopeActive = resolved.startAccessingSecurityScopedResource()
        fileScopeURL = resolved
    }

    func endFileSecurityScope() {
        if fileScopeActive, let fileScopeURL {
            fileScopeURL.stopAccessingSecurityScopedResource()
        }
        fileScopeActive = false
        fileScopeURL = nil
    }
}
