// InterBubbleNote — the slot that sits between two bubbles: shows the composer while
// editing, the saved note card if one exists, otherwise the hover-only add affordance.
// A note is anchored to the turn it sits ABOVE (that turn's uuid), so it keeps its place
// across re-dumps.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import SwiftUI

struct InterBubbleNote: View {
    @Bindable var state: AppState
    let uuid: String
    @State var draft = ""

    var saved: String { state.notes.record(for: uuid).text }
    private var isEditing: Bool { state.noteEditingUUID == uuid }

    var body: some View {
        Group {
            if isEditing {
                NoteComposerView(draft: $draft, onSave: commit,
                                 onCancel: { state.noteEditingUUID = nil })
            } else if !saved.isEmpty {
                SavedNoteView(text: saved) { begin() }
            } else {
                NoteInsertAffordance { begin() }
            }
        }
        .id(uuid)                                // scroll target for the notes timeline
    }
}
