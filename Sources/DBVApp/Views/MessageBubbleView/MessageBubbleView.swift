// MessageBubbleView — one turn: role label, metadata line, star/copy, body text.
// Notes are NOT in here: they live between bubbles (InterBubbleNote). Keeping a second note affordance inside the bubble would be
// two competing ways to do one thing.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI
import DBVCore

struct MessageBubbleView: View {
    @Bindable var state: AppState
    let message: JSONLMessage

    private var isUser: Bool { message.role == "user" }
    private var isStarred: Bool { state.notes.record(for: message.id).starred }

    var body: some View {
        HStack {
            if isUser { Spacer(minLength: 40) }
            VStack(alignment: .leading, spacing: 4) {
                header
                Text(message.text).textSelection(.enabled)
            }
            .padding(10)
            .background(isUser ? Color.accentColor.opacity(0.15) : Color.gray.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            // Starred turns get a rail so they're findable while scrolling fast.
            .overlay(alignment: .leading) {
                if isStarred {
                    Rectangle().fill(.yellow).frame(width: 4)
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                }
            }
            if !isUser { Spacer(minLength: 40) }
        }
    }

    private var header: some View {
        HStack(spacing: 6) {
            Text(jsonlRoleLabel(message.role))
                .font(.caption).bold().foregroundStyle(.secondary)
            TurnMetaView(message: message)
            Spacer()
            StarButton(state: state, uuid: message.id)
            CopyButton(text: message.text)
        }
    }
}
