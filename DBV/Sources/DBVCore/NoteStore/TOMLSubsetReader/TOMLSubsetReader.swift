// TOMLSubsetReader — line-by-line state machine for the minimal TOML subset note files
// use: key = "value" and triple-quoted """multi-line""" values. Ported from Show You's
// shipping TOMLSubsetReader — reused rather than re-derived because a hand-rolled TOML
// parser is where subtle bugs live. Multi-line strings are how note text containing
// quotes/newlines round-trips without escaping logic this reader lacks.
// The multi-line continuation half lives in TOMLSubsetReader+Multiline.swift.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

struct TOMLSubsetReader {
    private(set) var sections: [String: [String: String]] = [:]
    var section = ""
    var pendingKey: String?          // non-nil while collecting a """multi-line""" value
    var pendingLines: [String] = []

    mutating func consume(_ line: String) {
        if pendingKey != nil { consumeMultilineBody(line); return }
        let trimmed = line.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty || trimmed.hasPrefix("#") { return }
        if trimmed.hasPrefix("["), trimmed.hasSuffix("]") {
            section = String(trimmed.dropFirst().dropLast()); return
        }
        guard let eq = trimmed.firstIndex(of: "=") else { return }
        let key = trimmed[trimmed.startIndex..<eq].trimmingCharacters(in: .whitespaces)
        var value = String(trimmed[trimmed.index(after: eq)...]).trimmingCharacters(in: .whitespaces)
        if value.hasPrefix("\"\"\"") {
            value.removeFirst(3)
            if value.hasSuffix("\"\"\"") { value.removeLast(3); store(key, value) }
            else { pendingKey = key; if !value.isEmpty { pendingLines.append(value) } }
            return
        }
        // A single-line "value" may carry a trailing # comment — cut at the closing quote.
        if value.hasPrefix("\"") {
            let body = value.dropFirst()
            value = String(body[body.startIndex..<(body.firstIndex(of: "\"") ?? body.endIndex)])
        }
        store(key, value)
    }

    mutating func store(_ key: String, _ value: String) {
        sections[section, default: [:]][key] = value
    }
}
