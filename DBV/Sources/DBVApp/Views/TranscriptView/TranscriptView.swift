// TranscriptView — the "neat jsonl view". Each turn is preceded by an InterBubbleNote
// slot, so notes live BETWEEN bubbles rather than inside them. The notes timeline is an
// optional right-hand inspector; clicking a row scrolls here via ScrollViewReader.
// PERFORMANCE (2026-08-18 audit): LazyVStack + background parsing; AX element count on a
// 700-turn session dropped 1384 -> 268. The .jsonl is opened READ-ONLY, always.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI
import DBVCore

struct TranscriptView: View {
    @Bindable var state: AppState
    let title: String
    let jsonlURL: URL
    @State private var messages: [JSONLMessage] = []
    @State private var loadResult: JSONLLoadResult?
    @State private var reloadGeneration = 0

    private var visible: [JSONLMessage] {
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
            let granted = await offerGodLogPanelIfNeeded(readFailed: result.readFailed)
            if granted { reloadGeneration += 1 }
        }
    }

    @ViewBuilder
    private var transcriptBody: some View {
        if loadResult == nil {
            ProgressView("Reading jsonl…")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if messages.isEmpty {
            EmptyTranscriptView(
                filename: jsonlURL.lastPathComponent,
                parsedCount: messages.count,
                readFailed: loadResult?.readFailed ?? false,
                sourceLineCount: loadResult?.sourceLineCount ?? 0
            )
        } else if visible.isEmpty {
            ContentUnavailableView(
                "No turns match",
                systemImage: "magnifyingglass",
                description: Text("Clear the search box or turn off starred-only to see all \(messages.count) turns.")
            )
        } else {
            TranscriptScroll(state: state, messages: visible)
        }
    }
}
