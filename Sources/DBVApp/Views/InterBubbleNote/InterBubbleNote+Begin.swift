// InterBubbleNote+Begin — start editing this note from its saved text.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import SwiftUI

extension InterBubbleNote {
    func begin() {
        draft = saved
        state.noteEditingUUID = uuid
    }
}
