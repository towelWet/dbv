// GodParseToolResult — one tool_result event -> DBV tool turn.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func godParseToolResult(_ obj: [String: Any], lineIndex: Int) -> JSONLMessage {
    let name = (obj["tool_name"] as? String) ?? "tool"
    let out = (obj["tool_output"] as? String) ?? ""
    let short = out.count > 500 ? String(out.prefix(500)) + "…" : out
    let pfx = (obj["is_error"] as? Bool) == true ? "⚠ \(name)" : "↩ \(name)"
    return JSONLMessage(
        id: "god-result-\(lineIndex)", role: "tool_result", text: "\(pfx):\n\(short)", timestamp: nil)
}
