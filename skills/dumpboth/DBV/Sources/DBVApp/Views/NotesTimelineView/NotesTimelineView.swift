// NotesTimelineView — the inspector panel listing every note in this transcript, in
// transcript order, on a continuous rail. Click a row to jump the transcript to it.
// Ordering comes from the message list (not the dictionary), so the timeline always
// reads top-to-bottom the way the conversation actually ran.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI
import DBVCore

struct NotesTimelineView: View {
    @Bindable var state: AppState
    let messages: [JSONLMessage]
    let onJump: (String) -> Void

    private var noted: [JSONLMessage] {
        messages.filter { !state.notes.record(for: $0.id).text.isEmpty }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Notes")
                .font(.headline)
                .padding(.horizontal, 12).padding(.top, 12).padding(.bottom, 6)
            if noted.isEmpty {
                Text("Hover between messages to add one.")
                    .font(.caption).foregroundStyle(.secondary)
                    .padding(.horizontal, 12)
                Spacer()
            } else {
                List(noted) { message in
                    NotesTimelineRow(
                        text: state.notes.record(for: message.id).text,
                        clock: formatClockTime(message.timestamp),
                        starred: state.notes.record(for: message.id).starred
                    ) { onJump(message.id) }
                }
                .listStyle(.sidebar)
            }
        }
        .frame(width: 260)
        .background(.regularMaterial)
    }
}
