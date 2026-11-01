// TranscriptView+Body — loading, empty, no-match, or scrolling transcript.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import SwiftUI
import DBVCore

extension TranscriptView {
    @ViewBuilder
    var transcriptBody: some View {
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
