// ScanJSONLSessions — list God CLI s-*.jsonl in a folder (no oldchat pair required).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func scanJSONLSessions(in directory: URL) -> [DumpPair] {
    let fm = FileManager.default
    guard let entries = try? fm.contentsOfDirectory(
        at: directory,
        includingPropertiesForKeys: nil
    ) else { return [] }

    return entries
        .compactMap(jsonlSessionDumpPair)
        .sorted { $0.id > $1.id }
}
