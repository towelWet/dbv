// ReadJSONLBytes — raw read attempts. Caller holds security scope if needed.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func readJSONLBytes(url: URL) -> String? {
    for candidate in readJSONLCandidateURLs(url) {
        if let data = try? Data(contentsOf: candidate, options: [.mappedIfSafe]) {
            return String(decoding: data, as: UTF8.self)
        }
        if let text = try? String(contentsOf: candidate, encoding: .utf8) { return text }
        if let data = FileManager.default.contents(atPath: candidate.path) {
            return String(decoding: data, as: UTF8.self)
        }
    }
    return nil
}
