// GodLogBookmarksDirectory — persisted security-scoped bookmarks for ~/.god/logs.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func godLogBookmarksDirectory() -> URL {
    let base = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    let dir = base.appendingPathComponent("com.TowelWare.DBV/god-log-bookmarks", isDirectory: true)
    try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
    return dir
}
