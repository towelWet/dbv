// IsGodLogSessionBasename — God CLI session jsonl name pattern (s-*.jsonl).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func isGodLogSessionBasename(_ name: String) -> Bool {
    name.hasPrefix("s-") && name.hasSuffix(".jsonl")
}
