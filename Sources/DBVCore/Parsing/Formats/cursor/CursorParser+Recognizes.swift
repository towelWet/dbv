// CursorParser+Recognizes — is this line from Cursor?
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension CursorParser {
    func recognizes(_ obj: [String: Any]) -> Bool {
        // Claude lines also have message; they always set top-level type. Cursor
        // turns do not. That split keeps one line from matching two parsers.
        guard obj["type"] == nil else { return false }
        guard let role = obj["role"] as? String else { return false }
        guard role == "user" || role == "assistant" else { return false }
        return obj["message"] is [String: Any]
    }
}
