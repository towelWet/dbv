// TranscriptToolbar — window toolbar for a transcript: toggle the notes timeline, and
// copy the whole (filtered) transcript. Split out of TranscriptView.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI
import AppKit                                               // NSWorkspace for open-in-app
import DBVCore

struct TranscriptToolbar: ToolbarContent {
    @Bindable var state: AppState
    let messages: [JSONLMessage]
    var jsonlURL: URL?                                      // file to open externally

    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button {
                state.showTimeline.toggle()
            } label: {
                Label("Notes", systemImage: state.showTimeline ? "note.text" : "note")
            }
            .help("Show notes timeline")
        }
        ToolbarItem(placement: .primaryAction) {
            CopyButton(text: formatTranscriptForCopy(messages), labeled: true)
        }
        if let url = jsonlURL {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    openRaw(url)                            // show raw source file
                } label: {
                    Label("Open Raw JSONL", systemImage: "doc.plaintext")
                }
                .help("View raw JSONL")
            }
        }
    }

    /// Open raw file in user's app for it; plain .jsonl often has none, so fall back to TextEdit.
    private func openRaw(_ url: URL) {
        let app = NSWorkspace.shared.urlForApplication(toOpen: url)      // user's handler, if any
            ?? NSWorkspace.shared.urlForApplication(                     // ships with every Mac
                withBundleIdentifier: "com.apple.TextEdit")
        guard let app else { return }                       // no handler and no TextEdit: nothing to do
        NSWorkspace.shared.open(                            // async open, fire-and-forget
            [url], withApplicationAt: app,
            configuration: NSWorkspace.OpenConfiguration()
        )
    }
}
