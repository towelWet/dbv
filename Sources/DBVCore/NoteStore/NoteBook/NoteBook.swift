// NoteBook — every note for ONE dump, held in memory keyed by turn uuid. Mirrors the
// on-disk folder (db/<dump-stem>/<turn-uuid>.toml, one file per note).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public struct NoteBook: Sendable, Equatable {
    public var records: [String: NoteRecord]

    public init(records: [String: NoteRecord] = [:]) { self.records = records }

    public func record(for uuid: String) -> NoteRecord {
        records[uuid] ?? NoteRecord(turnUUID: uuid)
    }

    public var noteCount: Int { records.values.filter { !$0.text.isEmpty }.count }
    public var starredCount: Int { records.values.filter(\.starred).count }
}
