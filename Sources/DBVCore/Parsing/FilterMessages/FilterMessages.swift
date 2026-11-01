// FilterMessages — apply the search box and the starred-only toggle to a turn list.
// Pure function (messages + criteria in, messages out) so the view stays declarative
// and this stays independently testable.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func filterMessages(
    _ messages: [JSONLMessage],
    search: String,
    starredOnly: Bool,
    notes: NoteBook
) -> [JSONLMessage] {
    messages.filter { message in
        if starredOnly && !notes.record(for: message.id).starred { return false }
        guard !search.isEmpty else { return true }
        // Search covers the human note too, not just transcript text — a note is often
        // the most memorable handle on a turn ("the bit where the build broke").
        let note = notes.record(for: message.id).text
        return message.text.localizedCaseInsensitiveContains(search)
            || note.localizedCaseInsensitiveContains(search)
    }
}
