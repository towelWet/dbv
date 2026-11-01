// PrepareDocumentOpen — LS security scope first, then read + coordinator.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import DBVCore

func prepareDocumentOpen(_ url: URL) -> DocumentOpenPrepared {
    var scopeURL: URL?
    var scopeActive = false
    if urlIsDirectory(url) {
        _ = url.startAccessingSecurityScopedResource()
        return DocumentOpenPrepared(
            displayURL: url, scopeURL: url, scopeActive: true, prefetchedText: nil
        )
    }
    for candidate in fileOpenScopeCandidateURLs(url) {
        if candidate.startAccessingSecurityScopedResource() {
            scopeURL = candidate
            scopeActive = true
            break
        }
    }
    let display = url
    var text = readJSONLText(url: display)
    if text == nil {
        for candidate in readJSONLCandidateURLs(display) {
            if let chunk = readJSONLBytesForURL(candidate) { text = chunk; break }
        }
    }
    if text == nil, let scopeURL { text = readJSONLText(url: scopeURL) }
    return DocumentOpenPrepared(
        displayURL: display,
        scopeURL: scopeURL,
        scopeActive: scopeActive,
        prefetchedText: text
    )
}
