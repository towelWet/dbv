// FileOpenScopeCandidateURLs — LS opener URL first (grant), then standardized variants.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func fileOpenScopeCandidateURLs(_ url: URL) -> [URL] {
    [url]                                              // only opener URL carries the grant
}
