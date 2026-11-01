// NoteInsertAffordance — the thin "add note here" line that lives BETWEEN bubbles.
// Apple-style restraint: invisible until you hover that gap, then a hairline rule and a
// small ⊕ fade in. Nothing permanent is added to the reading surface, so a transcript
// with no notes looks exactly as clean as before the feature existed.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI

struct NoteInsertAffordance: View {
    let onAdd: () -> Void
    @State private var hovering = false

    var body: some View {
        Button(action: onAdd) {
            HStack(spacing: 6) {
                Rectangle().fill(.tertiary).frame(height: 1)
                Image(systemName: "plus.circle.fill").font(.caption)
                Text("Note").font(.caption2)
                Rectangle().fill(.tertiary).frame(height: 1)
            }
            .foregroundStyle(.secondary)
            .opacity(hovering ? 1 : 0)          // the whole affordance is hover-gated
        }
        .buttonStyle(.plain)
        .frame(height: 14)
        .contentShape(Rectangle())              // keep the full gap hoverable/clickable
        .onHover { hovering = $0 }
        .animation(.easeOut(duration: 0.15), value: hovering)
        .help("Add a note here")
    }
}
