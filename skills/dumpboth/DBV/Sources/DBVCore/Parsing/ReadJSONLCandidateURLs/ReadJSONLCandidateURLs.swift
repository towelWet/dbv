// ReadJSONLCandidateURLs — ~/.god/logs read path before resolved external target.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func readJSONLCandidateURLs(_ url: URL) -> [URL] {
    var seen = Set<String>()
    var out: [URL] = []
    func add(_ candidate: URL) {
        let key = candidate.path
        guard seen.insert(key).inserted else { return }
        out.append(candidate)
    }
    add(url)
    add(URL(fileURLWithPath: url.path))
    add(url.standardizedFileURL)
    if let session = godLogSessionReadURL(for: url) { add(session) }
    if let alias = godLogHomeAliasURL(for: url) { add(alias) }
    if url.path.contains("/.god/logs/") { add(url) }
    add(url.resolvingSymlinksInPath())
    return out
}
