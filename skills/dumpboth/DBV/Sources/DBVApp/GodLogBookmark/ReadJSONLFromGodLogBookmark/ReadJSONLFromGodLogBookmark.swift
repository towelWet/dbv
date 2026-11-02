// ReadJSONLFromGodLogBookmark — read bytes using a persisted security-scoped bookmark.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import DBVCore

func readJSONLFromGodLogBookmark(basename: String) -> String? {
    guard let url = resolveGodLogSecurityBookmark(basename: basename) else { return nil }
    let scoped = url.startAccessingSecurityScopedResource()
    defer { if scoped { url.stopAccessingSecurityScopedResource() } }
    return readJSONLBytesForURL(url)
}
