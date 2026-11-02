// RenderContentBlock — turn one raw jsonl "content" block (text / tool_use / tool_result)
// into a short human-readable line. Split out of ParseJSONLTranscript.swift per
// /split-files so the parser stays a pure line-walking loop. The actual rendering for
// tool_use/tool_result lives in DescribeToolUse.swift / DescribeToolResult.swift — this
// is just the dispatch by block type.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func renderContentBlock(_ block: [String: Any]) -> String? {
    guard let type = block["type"] as? String else { return nil }

    switch type {
    case "text":
        return block["text"] as? String

    case "tool_use":
        let name = block["name"] as? String ?? "tool"
        return describeToolUse(name: name, input: block["input"] as? [String: Any])

    case "tool_result":
        return describeToolResult(content: block["content"])

    default:
        return nil                                  // thinking blocks, images, etc. — skipped in the neat view
    }
}
