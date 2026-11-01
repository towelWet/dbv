// InterBubbleNote+Commit — save trimmed draft and leave edit mode.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import SwiftUI

extension InterBubbleNote {
    func commit() {
        state.updateNote(uuid: uuid) { $0.text = draft.trimmingCharacters(in: .whitespacesAndNewlines) }
        state.noteEditingUUID = nil
    }
}
