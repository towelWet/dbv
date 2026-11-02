// JSONLLoadResult — parse outcome for the GUI. Distinguishes "could not read"
// from "read N lines, 0 matching turns" so a blank window is not silent.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public struct JSONLLoadResult: Sendable {
    public let messages: [JSONLMessage]
    public let readFailed: Bool
    public let sourceLineCount: Int

    public init(messages: [JSONLMessage], readFailed: Bool, sourceLineCount: Int) {
        self.messages = messages
        self.readFailed = readFailed
        self.sourceLineCount = sourceLineCount
    }
}
