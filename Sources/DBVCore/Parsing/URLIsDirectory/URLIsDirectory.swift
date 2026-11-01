// URLIsDirectory — true when the path exists as a folder (not a jsonl file).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func urlIsDirectory(_ url: URL) -> Bool {
    var isDir: ObjCBool = false
    guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir) else {
        return url.hasDirectoryPath
    }
    return isDir.boolValue
}
