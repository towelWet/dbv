// GodLogOpenTargetURL — derive panel target from the document the user already opened.
import Foundation

func godLogOpenTargetURL(preferredFileURL: URL?, suggestedName: String) -> (directory: URL, basename: String?)? {
    let logsHome = FileManager.default.homeDirectoryForCurrentUser
        .appendingPathComponent(".god/logs", isDirectory: true)
    let target = preferredFileURL ?? (suggestedName.isEmpty ? nil : logsHome.appendingPathComponent(suggestedName))
    guard let target else { return nil }
    let directory = target.deletingLastPathComponent().resolvingSymlinksInPath()
    return (directory, target.lastPathComponent)
}
