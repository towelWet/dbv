// ClaudeParser+Recognizes — is this line from Claude?
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension ClaudeParser {
    func recognizes(_ obj: [String: Any]) -> Bool {
        guard let lineType = obj["type"] as? String else { return false }
        guard lineType == "user" || lineType == "assistant" else { return false }
        return obj["message"] is [String: Any]
    }
}
