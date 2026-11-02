// FileOpenScopeCandidateURLs — LS opener URL first (grant), then ~/.god/logs alias.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func fileOpenScopeCandidateURLs(_ url: URL) -> [URL] {
    var seen = Set<String>()
    var out: [URL] = []
    func add(_ candidate: URL) {
        let key = candidate.path
        guard seen.insert(key).inserted else { return }
        out.append(candidate)
    }
    add(url)
    if let alias = godLogHomeAliasURL(for: url) { add(alias) }
    if let session = godLogSessionReadURL(for: url) { add(session) }
    return out
}
