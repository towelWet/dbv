// GodLogSessionReadURL — always read God CLI s-*.jsonl via ~/.god/logs/<name>.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func godLogSessionReadURL(for url: URL) -> URL? {
    let name = url.lastPathComponent
    guard name.hasPrefix("s-"), name.hasSuffix(".jsonl") else { return nil }
    return FileManager.default.homeDirectoryForCurrentUser
        .appending(path: ".god/logs/\(name)")
}
