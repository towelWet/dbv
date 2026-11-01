// AppState+AdoptDocumentOpen — keep LS scope; retry read while scope is active.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import DBVCore

extension AppState {
    func adoptDocumentOpen(_ prep: DocumentOpenPrepared) {
        if urlIsDirectory(prep.displayURL) {
            browserRoot = prep.displayURL
            mode = .browser
            loadBrowser()
            return
        }
        clearStaleTranscriptFilters(whenOpening: prep.displayURL)
        if fileScopeActive, fileScopeURL != prep.scopeURL { endFileSecurityScope() }
        fileScopeURL = prep.scopeURL
        fileScopeActive = prep.scopeActive
        var text = prep.prefetchedText
        if text == nil {
            for candidate in readJSONLCandidateURLs(prep.displayURL) {
                if let chunk = readJSONLBytesForURL(candidate) { text = chunk; break }
            }
        }
        prefetchedJSONLText = text
        prefetchedJSONLName = prep.displayURL.lastPathComponent
        mode = .singleFile(prep.displayURL)
    }
}
