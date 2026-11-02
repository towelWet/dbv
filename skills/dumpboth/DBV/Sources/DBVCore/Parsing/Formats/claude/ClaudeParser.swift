// ClaudeParser — Claude Code session jsonl. Line owns type=user|assistant + message.
// Drop this folder to add/remove the dialect; do not list it in ParseJSONLTranscript.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

struct ClaudeParser: JSONLLineParser {
    func recognizes(_ obj: [String: Any]) -> Bool {
        guard let lineType = obj["type"] as? String else { return false }
        guard lineType == "user" || lineType == "assistant" else { return false }
        return obj["message"] is [String: Any]
    }

    func parse(_ obj: [String: Any], lineIndex: Int) -> JSONLMessage? {
        guard let message = obj["message"] as? [String: Any] else { return nil }
        return makeJSONLMessage(line: obj, message: message, lineIndex: lineIndex)
    }
}
