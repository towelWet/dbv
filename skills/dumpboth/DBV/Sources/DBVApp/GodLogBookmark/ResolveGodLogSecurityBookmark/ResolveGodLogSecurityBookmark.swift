// ResolveGodLogSecurityBookmark — reload scoped URL from Application Support bookmark.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func resolveGodLogSecurityBookmark(basename: String) -> URL? {
    let file = godLogBookmarksDirectory().appendingPathComponent(basename + ".bookmark")
    guard let data = try? Data(contentsOf: file) else { return nil }
    var stale = false
    return try? URL(
        resolvingBookmarkData: data,
        options: .withSecurityScope,
        relativeTo: nil,
        bookmarkDataIsStale: &stale
    )
}
