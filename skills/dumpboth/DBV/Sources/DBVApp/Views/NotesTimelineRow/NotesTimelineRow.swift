// NotesTimelineRow — one entry in the notes timeline: a rail dot, the note's own text,
// and the timestamp of the turn it sits above. Clicking scrolls the transcript to it.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI
import DBVCore

struct NotesTimelineRow: View {
    let text: String
    let clock: String?
    let starred: Bool
    let onJump: () -> Void

    var body: some View {
        Button(action: onJump) {
            HStack(alignment: .top, spacing: 8) {
                // The rail: a small dot in a continuous vertical line reads as a timeline
                // rather than a plain list — the Apple pattern for ordered moments.
                Circle().fill(starred ? .yellow : .orange)
                    .frame(width: 7, height: 7)
                    .padding(.top, 5)
                VStack(alignment: .leading, spacing: 2) {
                    Text(text).font(.callout).lineLimit(3)
                    if let clock {
                        Text(clock).font(.caption2).foregroundStyle(.secondary)
                    }
                }
                Spacer(minLength: 0)
            }
            .padding(.vertical, 4)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
