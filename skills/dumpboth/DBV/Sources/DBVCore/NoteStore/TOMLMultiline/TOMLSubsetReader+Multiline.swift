// TOMLSubsetReader+Multiline — the continuation half of the reader: accumulates lines of
// a """multi-line""" value until the closing delimiter. Split from the main reader so
// each file holds one concern and stays under the 50-line ceiling.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension TOMLSubsetReader {
    mutating func consumeMultilineBody(_ line: String) {
        guard let key = pendingKey else { return }
        if line.hasSuffix("\"\"\"") {
            let head = String(line.dropLast(3))
            if !head.isEmpty { pendingLines.append(head) }
            store(key, pendingLines.joined(separator: "\n"))
            pendingKey = nil
            pendingLines = []
        } else {
            pendingLines.append(line)
        }
    }
}
