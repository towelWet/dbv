// TruncateOneLine — collapse a multi-line string to one readable line, capped at a
// length. Shared by DescribeToolUse and DescribeToolResult so a long command/result
// never breaks the transcript's one-line-per-bubble-row rhythm.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func truncateOneLine(_ text: String, limit: Int = 160) -> String {
    let collapsed = text.replacingOccurrences(of: "\n", with: " ⏎ ")
    return collapsed.count > limit ? String(collapsed.prefix(limit)) + "…" : collapsed
}
