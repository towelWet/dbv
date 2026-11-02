// FormatTokenUsage — compact per-turn token cost line, e.g. "46.8k cached · 289 out".
// Built from the assistant message's `usage` dict, which real dumps already carry on
// every assistant line (input/cache_creation/cache_read/output). Display only.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func formatTokenUsage(cacheRead: Int?, output: Int?) -> String? {
    var parts: [String] = []
    if let cacheRead, cacheRead > 0 { parts.append("\(abbreviateCount(cacheRead)) cached") }
    if let output, output > 0 { parts.append("\(abbreviateCount(output)) out") }
    return parts.isEmpty ? nil : parts.joined(separator: " · ")
}
