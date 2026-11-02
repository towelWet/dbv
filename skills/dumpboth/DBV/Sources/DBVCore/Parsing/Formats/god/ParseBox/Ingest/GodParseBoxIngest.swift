// GodParseBoxIngest — map one god jsonl object into queued turns.
import Foundation

func godParseBoxIngest(_ box: GodParseBox, _ obj: [String: Any], lineIndex: Int) {
    guard let kind = obj["kind"] as? String else { return }
    let lineTs = (obj["ts"] as? NSNumber).map { String(describing: $0) }
    switch kind {
    case "text":
        if box.textBuf.isEmpty { box.textStart = lineIndex; box.textTs = lineTs }
        box.textBuf += (obj["text"] as? String) ?? ""
    case "user":
        godParseBoxFlushText(box)
        let t = ((obj["text"] as? String) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !t.isEmpty else { return }
        box.pending.append(JSONLMessage(id: "god-user-\(lineIndex)", role: "user", text: t, timestamp: lineTs))
    case "tool_call":
        godParseBoxFlushText(box)
        let name = (obj["name"] as? String) ?? "tool"
        box.pending.append(JSONLMessage(
            id: "god-tool-\(lineIndex)", role: "tool_call",
            text: godDescribeTool(name, (obj["input"] as? String) ?? ""), timestamp: lineTs))
    case "tool_result":
        box.pending.append(godParseToolResult(obj, lineIndex: lineIndex))
    case "done": godParseBoxFlushText(box)
    default: break
    }
}
