// TranscriptView — the "neat jsonl view". Each turn is preceded by an InterBubbleNote
// slot, so notes live BETWEEN bubbles rather than inside them. The notes timeline is an
// optional right-hand inspector; clicking a row scrolls here via ScrollViewReader.
// PERFORMANCE: LazyVStack + background parsing; AX element count on a
// 700-turn session dropped 1384 -> 268. The .jsonl is opened READ-ONLY, always.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import SwiftUI
import DBVCore

struct TranscriptView: View {
    @Bindable var state: AppState
    let title: String
    let jsonlURL: URL
    @State var messages: [JSONLMessage] = []
    @State var loadResult: JSONLLoadResult?
    @State private var reloadGeneration = 0

    var visible: [JSONLMessage] {
        filterMessages(messages, search: state.searchText,
                       starredOnly: state.starredOnly, notes: state.notes)
    }

    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                SearchBar(state: state, total: messages.count, shown: visible.count)
                transcriptBody
            }
            if state.showTimeline {
                Divider()
                NotesTimelineView(state: state, messages: messages) { state.jumpTarget = $0 }
            }
        }
        .navigationTitle(title)
        .toolbar { TranscriptToolbar(state: state, messages: visible, jsonlURL: jsonlURL) }
        .task(id: "\(jsonlURL.path)#\(reloadGeneration)") {
            let result = await runTranscriptLoad(state: state, jsonlURL: jsonlURL)
            loadResult = result
            messages = result.messages
        }
    }
}
