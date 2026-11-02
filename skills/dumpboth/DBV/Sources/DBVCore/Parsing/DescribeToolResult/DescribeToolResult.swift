// DescribeToolResult — render a tool_result block's real content. Handles BOTH shapes
// the API actually sends: a plain string, or an array of {type:"text", text:...}
// blocks (the previous code only handled the string case — anything else silently
// became the bare placeholder "(tool result)", another slice of the "data's missing"
// bug report 2026-08-18). Extracted from RenderContentBlock.swift per /split-files.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func describeToolResult(content: Any?) -> String {
    if let text = content as? String {
        return "← \(truncateOneLine(text))"
    }
    if let blocks = content as? [[String: Any]] {
        let text = blocks.compactMap { $0["text"] as? String }.joined(separator: " ")
        if !text.isEmpty { return "← \(truncateOneLine(text))" }
    }
    return "← (tool result)"
}
