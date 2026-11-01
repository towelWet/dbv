// DumpFolderPath — each dump gets its OWN folder in the db, named by the dump's stem
// (e.g. db/oldchat2-dumpboth-919b69e1/). Many note files live inside it — one per note.
// Deliberately not one monolithic notes file: each dump is a folder.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public enum DumpFolderPath {
    public static func folder(forJSONL jsonlURL: URL) -> URL {
        let stem = jsonlURL.deletingPathExtension().lastPathComponent
        return DBRoot.url.appendingPathComponent(stem, isDirectory: true)
    }
}
