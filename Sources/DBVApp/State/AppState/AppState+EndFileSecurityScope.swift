// AppState+EndFileSecurityScope — release current file scope, if any.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension AppState {
    func endFileSecurityScope() {
        if fileScopeActive, let fileScopeURL {
            fileScopeURL.stopAccessingSecurityScopedResource()
        }
        fileScopeActive = false
        fileScopeURL = nil
    }
}
