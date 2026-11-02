// GodFirstUserPreview — first kind=user text for the sidebar (read-only, one line).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func godFirstUserPreview(url: URL) -> String? {
    guard let text = readJSONLBytesForURL(url) else { return nil }
    for line in text.split(separator: "\n", omittingEmptySubsequences: true) {
        guard let obj = try? JSONSerialization.jsonObject(with: Data(line.utf8)) as? [String: Any],
              obj["kind"] as? String == "user" else { continue }
        let raw = ((obj["text"] as? String) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !raw.isEmpty else { continue }
        let one = raw.replacingOccurrences(of: "\n", with: " ")
        return one.count > 80 ? String(one.prefix(80)) + "…" : one
    }
    return nil
}
