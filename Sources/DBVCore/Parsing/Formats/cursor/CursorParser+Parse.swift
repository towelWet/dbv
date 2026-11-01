// CursorParser+Parse — one recognized Cursor line to message.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension CursorParser {
    func parse(_ obj: [String: Any], lineIndex: Int) -> JSONLMessage? {
        guard let message = obj["message"] as? [String: Any] else { return nil }
        return makeJSONLMessage(line: obj, message: message, lineIndex: lineIndex)
    }
}
