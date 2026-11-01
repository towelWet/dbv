// ParseJSONLTranscript — read a session .jsonl into a turn list. STRICTLY READ-ONLY.
// Dialect matching is delegated to discoveredFormatParsers() (filesystem glob at
// generate time). This file is only the line loop.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func parseJSONLTranscript(url: URL) -> [JSONLMessage] {
    loadJSONLTranscript(url: url).messages
}

public func parseJSONLTranscript(text: String) -> [JSONLMessage] {
    let parsers = discoveredFormatParsers()
    var messages: [JSONLMessage] = []
    var index = 0

    for line in text.split(separator: "\n", omittingEmptySubsequences: true) {
        index += 1
        guard let lineData = line.data(using: .utf8),
              let obj = try? JSONSerialization.jsonObject(with: lineData) as? [String: Any]
        else { continue }

        for parser in parsers {
            guard parser.recognizes(obj) else { continue }
            if let message = parser.parse(obj, lineIndex: index) {
                messages.append(message)
            }
            break
        }
    }
    return messages
}
