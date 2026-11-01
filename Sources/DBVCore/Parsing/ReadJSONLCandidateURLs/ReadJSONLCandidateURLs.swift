// ReadJSONLCandidateURLs — path variants to try when reading a jsonl (standardized, resolved).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func readJSONLCandidateURLs(_ url: URL) -> [URL] {
    uniqueURLsByPath([url, URL(fileURLWithPath: url.path), url.standardizedFileURL, url.resolvingSymlinksInPath()])
}
