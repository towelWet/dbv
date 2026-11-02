// JSONLLoadResultFromText — parse only; GUI read path avoids readJSONLText scope churn.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import DBVCore

func jsonlLoadResult(from text: String) -> JSONLLoadResult {
    let sourceLineCount = text.split(separator: "\n", omittingEmptySubsequences: true).count
    return JSONLLoadResult(
        messages: parseJSONLTranscript(text: text),
        readFailed: false,
        sourceLineCount: sourceLineCount
    )
}
