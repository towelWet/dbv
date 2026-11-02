// CursorParser — Cursor IDE agent-transcript jsonl. Line owns role=user|assistant
// and a message dict, with no Claude-style top-level type. Status/error lines
// carry type without role and are ignored. Do not rewrite dumps to look like Claude.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

struct CursorParser: JSONLLineParser {
    func recognizes(_ obj: [String: Any]) -> Bool {
        // Claude lines also have message; they always set top-level type. Cursor
        // turns do not. That split keeps one line from matching two parsers.
        guard obj["type"] == nil else { return false }
        guard let role = obj["role"] as? String else { return false }
        guard role == "user" || role == "assistant" else { return false }
        return obj["message"] is [String: Any]
    }

    func parse(_ obj: [String: Any], lineIndex: Int) -> JSONLMessage? {
        guard let message = obj["message"] as? [String: Any] else { return nil }
        return makeJSONLMessage(line: obj, message: message, lineIndex: lineIndex)
    }
}
