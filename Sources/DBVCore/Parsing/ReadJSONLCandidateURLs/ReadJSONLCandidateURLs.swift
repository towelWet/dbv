// ReadJSONLCandidateURLs — path variants to try when reading a jsonl (standardized, resolved).
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
    add(url.resolvingSymlinksInPath())
    return out
}
