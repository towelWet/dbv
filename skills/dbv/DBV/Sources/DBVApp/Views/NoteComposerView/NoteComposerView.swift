// NoteComposerView — the editing state of a human note: a text box plus save/cancel.
// Pure input UI; persistence is the caller's job (NoteEditorView -> AppState).
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI

struct NoteComposerView: View {
    @Binding var draft: String
    let onSave: () -> Void
    let onCancel: () -> Void
    // Auto-focus so typing works the instant the composer opens — without this the
    // TextEditor starts unfocused and keystrokes go nowhere (caught in live testing).
    @FocusState private var focused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            TextEditor(text: $draft)
                .frame(minHeight: 60)
                .font(.callout)
                .focused($focused)
                // Focus must be requested AFTER the editor joins the window's responder
                // chain — setting it directly in .onAppear is too early and silently
                // loses to whatever already held focus (the search field), which sent
                // typed notes into the search box during live testing. The async hop is
                // the fix, not a workaround: it defers to the next runloop turn.
                .task {
                    try? await Task.sleep(for: .milliseconds(50))
                    focused = true
                }
            HStack {
                Button("Save", action: onSave)
                    .keyboardShortcut(.return, modifiers: .command)
                Button("Cancel", action: onCancel)
                Spacer()
                Text("⌘↩ to save").font(.caption2).foregroundStyle(.secondary)
            }
        }
        .padding(8)
        .background(Color.yellow.opacity(0.16))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
