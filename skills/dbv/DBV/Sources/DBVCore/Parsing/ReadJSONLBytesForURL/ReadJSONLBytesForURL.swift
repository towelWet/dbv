// ReadJSONLBytesForURL — bytes + coordinator fallback for one URL.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func readJSONLBytesForURL(_ url: URL) -> String? {
    if let direct = readJSONLBytes(url: url) { return direct }
    return coordinateReadJSONL(url: url)
}
