// DumpPair — one row in DBV's overview sidebar: a matched .md + .jsonl produced by
// the SAME /dumpboth invocation (same oldchatN number, same random tag).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public struct DumpPair: Identifiable, Sendable {
    public let id: Int              // the oldchatN number — unique per dump, stable sort key
    public let tag: String?         // 8-hex tag /dumpboth mints; nil for a lone /dumpchat or /dumpjsonl file
    public let displayName: String  // what the sidebar shows, e.g. "oldchat42 — dumpboth"
    public let mdURL: URL?
    public let jsonlURL: URL?
    public let preview: String?     // first user prompt, when available; nil for plain dumpboth pairs

    public init(id: Int, tag: String?, displayName: String, mdURL: URL?, jsonlURL: URL?, preview: String? = nil) {
        self.id = id
        self.tag = tag
        self.displayName = displayName
        self.mdURL = mdURL
        self.jsonlURL = jsonlURL
        self.preview = preview
    }
}
