// DocumentOpenPrepared — scope + bytes captured during the LS open event (same runloop).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

struct DocumentOpenPrepared {
    let displayURL: URL
    let scopeURL: URL?
    let scopeActive: Bool
    let prefetchedText: String?
}
