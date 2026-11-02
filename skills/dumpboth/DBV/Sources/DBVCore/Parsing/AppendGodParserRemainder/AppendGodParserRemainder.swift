// AppendGodParserRemainder — flush queued god streaming turns after the line loop.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func appendGodParserRemainder(_ parsers: [any JSONLLineParser], into messages: inout [JSONLMessage]) {
    for parser in parsers {
        guard let god = parser as? GodParser else { continue }
        messages.append(contentsOf: god.drainRemainder())
    }
}
