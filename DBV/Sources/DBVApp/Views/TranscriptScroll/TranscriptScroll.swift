// TranscriptScroll — the scrolling body: an InterBubbleNote slot above every turn, then
// the turn itself. ScrollViewReader lets the notes timeline jump straight to a note.
// LazyVStack (not VStack) is load-bearing for performance — see TranscriptView's header.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI
import DBVCore

struct TranscriptScroll: View {
    @Bindable var state: AppState
    let messages: [JSONLMessage]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach(messages) { message in
                        InterBubbleNote(state: state, uuid: message.id)
                        MessageBubbleView(state: state, message: message)
                    }
                }
                .padding()
            }
            .onChange(of: state.jumpTarget) { _, target in
                guard let target else { return }
                withAnimation(.easeInOut(duration: 0.25)) { proxy.scrollTo(target, anchor: .center) }
                state.jumpTarget = nil            // one-shot: clear so the same row can be re-clicked
            }
        }
    }
}
