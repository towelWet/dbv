// RenderMessageBody — turn one message's content into (visible body, thinking text).
// Split out of ParseJSONLTranscript so that stays a pure line loop under the 50-line
// ceiling and this owns the "what does a message's content array mean" question.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func renderMessageBody(_ message: [String: Any]) -> (body: String, thinking: String?) {
    var rendered: [String] = []
    var thinking: [String] = []

    if let blocks = message["content"] as? [[String: Any]] {
        for block in blocks {
            if (block["type"] as? String) == "thinking", let t = block["thinking"] as? String {
                thinking.append(t)
            } else if let line = renderContentBlock(block) {
                rendered.append(line)
            }
        }
    } else if let contentString = message["content"] as? String {
        rendered.append(contentString)      // some lines carry a bare string, not blocks
    }

    return (rendered.joined(separator: "\n"), thinking.isEmpty ? nil : thinking.joined(separator: "\n"))
}
