// TranscriptToolbar — window toolbar for a transcript: toggle the notes timeline, and
// copy the whole (filtered) transcript. Split out of TranscriptView per /split-files.
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
                    openInTedit(url)                        // launch Tedit with file
                } label: {
                    Label("Open in Tedit", systemImage: "doc.plaintext")
                }
                .help("View raw JSONL in Tedit")
            }
        }
    }

    /// Open a file URL in Tedit (com.tedit.Tedit) using modern NSWorkspace API.
    private func openInTedit(_ url: URL) {
        let config = NSWorkspace.OpenConfiguration()        // default config
        let appURL = NSWorkspace.shared.urlForApplication(  // resolve Tedit path
            withBundleIdentifier: "com.tedit.Tedit"
        )
        guard let appURL else { return }                    // Tedit not installed
        NSWorkspace.shared.open(                            // async open, fire-and-forget
            [url], withApplicationAt: appURL,
            configuration: config
        )
    }
}
