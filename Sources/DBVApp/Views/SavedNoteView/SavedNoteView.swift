// SavedNoteView — a human note in its resting (non-editing) state. Yellow card so a
// human annotation is never visually confusable with real transcript content.
// Click to re-open it in NoteComposerView.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI

struct SavedNoteView: View {
    let text: String
    let onEdit: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            Image(systemName: "note.text").font(.caption)
            Text(text).font(.callout).textSelection(.enabled)
            Spacer()
        }
        .padding(8)
        .background(Color.yellow.opacity(0.16))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .contentShape(Rectangle())
        .onTapGesture(perform: onEdit)
    }
}
