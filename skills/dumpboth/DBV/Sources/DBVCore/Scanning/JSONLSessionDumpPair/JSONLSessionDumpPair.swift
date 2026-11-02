// JSONLSessionDumpPair — one s-*.jsonl row for the sidebar (jsonl-only, md is n/a).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func jsonlSessionDumpPair(_ url: URL) -> DumpPair? {
    let name = url.lastPathComponent
    guard isGodLogSessionBasename(name), !name.hasPrefix("._") else { return nil }
    let stem = String(name.dropLast(6))
    let digits = stem.drop(while: { !$0.isNumber })
    guard let number = Int(digits) else { return nil }
    return DumpPair(
        id: number, tag: nil, displayName: stem,
        mdURL: nil, jsonlURL: url, preview: godFirstUserPreview(url: url)
    )
}
