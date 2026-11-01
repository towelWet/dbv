// DescribeToolUse — render a tool_use block's ACTUAL arguments, not just its name.
// WHY IT EXISTS: the previous "→ Bash(…)" placeholder silently discarded the real
// command/skill/args. Extracted
// from RenderContentBlock.swift.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func describeToolUse(name: String, input: [String: Any]?) -> String {
    guard let input else { return "→ \(name)" }

    // Priority order matches the fields real tool calls actually carry: a shell
    // command is the most informative single field when present, then a skill
    // invocation's name+args, then a generic description, then a raw fallback dump.
    if let command = input["command"] as? String {
        return "→ \(name): \(truncateOneLine(command))"
    }
    if let skill = input["skill"] as? String {
        let args = (input["args"] as? String).map { " " + $0 } ?? ""
        return "→ \(name): \(skill)\(args)"
    }
    if let description = input["description"] as? String {
        return "→ \(name): \(description)"
    }
    if let filePath = input["file_path"] as? String {
        return "→ \(name): \(filePath)"
    }
    if let path = input["path"] as? String {
        return "→ \(name): \(path)"
    }
    // Generic fallback — show up to 2 key=value pairs so nothing reads as truly empty.
    let pairs = input.prefix(2).map { "\($0.key)=\(truncateOneLine(String(describing: $0.value)))" }
    return "→ \(name)(\(pairs.joined(separator: ", ")))"
}
