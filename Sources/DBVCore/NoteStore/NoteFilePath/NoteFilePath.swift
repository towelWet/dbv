// NoteFilePath — one note = one file, named by the turn uuid it's anchored to:
// db/<dump-stem>/<turn-uuid>.toml
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public enum NoteFilePath {
    public static func file(forJSONL jsonlURL: URL, turnUUID: String) -> URL {
        DumpFolderPath.folder(forJSONL: jsonlURL)
            .appendingPathComponent("\(turnUUID).toml")
    }
}
