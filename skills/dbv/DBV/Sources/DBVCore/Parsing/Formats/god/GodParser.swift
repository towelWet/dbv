// GodParser — mlx-magic / god CLI session jsonl (`kind` events, not Claude `type`).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

struct GodParser: JSONLLineParser {
    private let box = GodParseBox()

    func recognizes(_ obj: [String: Any]) -> Bool {
        guard obj["type"] == nil, obj["role"] == nil, obj["message"] == nil else { return false }
        guard let kind = obj["kind"] as? String else { return false }
        return ["text", "user", "tool_call", "tool_result", "done", "thinking", "usage"].contains(kind)
    }

    func parse(_ obj: [String: Any], lineIndex: Int) -> JSONLMessage? {
        if let queued = box.dequeue() { return queued }
        godParseBoxIngest(box, obj, lineIndex: lineIndex)
        return box.dequeue()
    }

    func drainRemainder() -> [JSONLMessage] {
        var out: [JSONLMessage] = []
        while let m = box.dequeue() { out.append(m) }
        out.append(contentsOf: box.drainTail())
        return out
    }
}
