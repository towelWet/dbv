// SaveGodLogSecurityBookmark — store panel/LS grant for next launch (no dump copy).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func saveGodLogSecurityBookmark(url: URL) {
    guard let data = try? url.bookmarkData(
        options: .withSecurityScope,
        includingResourceValuesForKeys: nil,
        relativeTo: nil
    ) else { return }
    let path = godLogBookmarksDirectory().appendingPathComponent(url.lastPathComponent + ".bookmark")
    try? data.write(to: path, options: .atomic)
}
