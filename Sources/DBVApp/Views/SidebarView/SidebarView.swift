// SidebarView — overview list. Selection is pair id so a click loads the transcript.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI
import DBVCore

struct SidebarView: View {
    @Bindable var state: AppState

    var body: some View {
        List(selection: $state.selectedID) {
            ForEach(state.pairs) { pair in
                VStack(alignment: .leading, spacing: 2) {
                    Text(pair.displayName)
                        .font(.system(.body, design: .monospaced))
                        .lineLimit(1)
                        .help(pair.displayName)
                    if let preview = pair.preview, !preview.isEmpty {
                        Text(preview)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    } else if pair.mdURL == nil || pair.jsonlURL == nil {
                        Text("incomplete pair")
                            .font(.caption)
                            .foregroundStyle(.orange)
                    }
                }
                .tag(Optional(pair.id))
                .contentShape(Rectangle())
                .onTapGesture { state.selectedID = pair.id }
            }
        }
        .navigationTitle("DBV — Dumps")
    }
}
