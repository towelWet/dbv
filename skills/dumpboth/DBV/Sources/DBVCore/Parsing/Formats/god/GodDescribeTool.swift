// GodDescribeTool — one-line summary of a god tool_call input JSON string.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func godDescribeTool(_ name: String, _ input: String) -> String {
    guard let d = input.data(using: .utf8),
          let a = try? JSONSerialization.jsonObject(with: d) as? [String: Any]
    else { return "🔧 \(name)(\(input.prefix(200)))" }
    if name == "bash" { return "$ \((a["command"] as? String) ?? input)" }
    if let p = a["file_path"] as? String { return "🔧 \(name) \(p)" }
    return "🔧 \(name)(\(input.prefix(200)))"
}
