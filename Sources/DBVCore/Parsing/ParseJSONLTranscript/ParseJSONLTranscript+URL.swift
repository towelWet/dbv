// ParseJSONLTranscript+URL — transcript from file: read, then parse. STRICTLY READ-ONLY.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func parseJSONLTranscript(url: URL) -> [JSONLMessage] {
    loadJSONLTranscript(url: url).messages
}
