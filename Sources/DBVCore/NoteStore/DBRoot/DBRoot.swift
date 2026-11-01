// DBRoot — where the note database lives: ~/.claude/skills/dumpboth/db/
// Built from homeDirectoryForCurrentUser + relative components so no personal path is
// ever hardcoded. DBV_DB_ROOT overrides it (tests, or a relocated skills tree).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public enum DBRoot {
    public static var url: URL {
        if let override = ProcessInfo.processInfo.environment["DBV_DB_ROOT"] {
            return URL(fileURLWithPath: override, isDirectory: true)
        }
        return FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent(".claude/skills/dumpboth/db", isDirectory: true)
    }
}
