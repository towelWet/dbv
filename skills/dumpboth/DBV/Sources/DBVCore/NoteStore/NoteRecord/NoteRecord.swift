// NoteRecord — ONE human note, stored as ONE file. Anchored to the turn it sits above
// by that turn's jsonl uuid, so notes survive a re-dump. The .jsonl is canonical and is
// never written to; all human data lives in the note store.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public struct NoteRecord: Identifiable, Sendable, Equatable {
    public var turnUUID: String     // which turn this note sits above
    public var text: String
    public var starred: Bool
    public var created: String      // ISO8601, set once at first save

    public var id: String { turnUUID }

    public init(turnUUID: String, text: String = "", starred: Bool = false, created: String = "") {
        self.turnUUID = turnUUID
        self.text = text
        self.starred = starred
        self.created = created
    }

    public var isEmpty: Bool { text.isEmpty && !starred }
}
