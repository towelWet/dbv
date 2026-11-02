// GodLogHomeAliasURL — ~/.god/logs/<name> when path is a external-drive .god-logs file.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func godLogHomeAliasURL(for url: URL) -> URL? {
    guard url.path.contains("/.god-logs/") else { return nil }
    let name = url.lastPathComponent
    return FileManager.default.homeDirectoryForCurrentUser
        .appending(path: ".god/logs/\(name)")
}
