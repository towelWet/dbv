// ReadJSONLText — read dump bytes with security scope (CLI/tests direct open).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func readJSONLText(url: URL) -> String? {
    let scoped = url.startAccessingSecurityScopedResource()
    defer {
        if scoped { url.stopAccessingSecurityScopedResource() }
    }
    return readJSONLBytes(url: url)
}
