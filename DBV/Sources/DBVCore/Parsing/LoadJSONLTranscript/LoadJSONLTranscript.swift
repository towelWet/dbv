// LoadJSONLTranscript — read + parse with a result the GUI can explain.
// parseJSONLTranscript(url:) stays the message-only wrapper used by tests.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func loadJSONLTranscript(url: URL) -> JSONLLoadResult {
    guard let text = readJSONLText(url: url) else {
        return JSONLLoadResult(messages: [], readFailed: true, sourceLineCount: 0)
    }
    let sourceLineCount = text.split(separator: "\n", omittingEmptySubsequences: true).count
    return JSONLLoadResult(
        messages: parseJSONLTranscript(text: text),
        readFailed: false,
        sourceLineCount: sourceLineCount
    )
}
