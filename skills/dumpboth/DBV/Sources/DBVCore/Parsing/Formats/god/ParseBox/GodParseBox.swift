// GodParseBox — queue for streaming god kind events.
import Foundation

final class GodParseBox: @unchecked Sendable {
    var pending: [JSONLMessage] = []
    var textBuf = ""
    var textStart = 0
    var textTs: String?

    func dequeue() -> JSONLMessage? {
        pending.isEmpty ? nil : pending.removeFirst()
    }

    func drainTail() -> [JSONLMessage] {
        godParseBoxFlushText(self)
        let out = pending
        pending = []
        return out
    }
}
