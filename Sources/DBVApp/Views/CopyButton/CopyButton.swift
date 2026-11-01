// CopyButton — one reusable copy-with-checkmark-feedback button, shared by
// MessageBubbleView's per-message copy and TranscriptView's toolbar Copy All.
// Extracted so that logic exists in exactly one place instead of being duplicated
// twice with slightly different styling each time.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import SwiftUI

struct CopyButton: View {
    let text: String
    var labeled: Bool = false           // false = icon-only (bubble), true = icon+text (toolbar)
    @State private var justCopied = false

    var body: some View {
        Button {
            copyToClipboard(text)
            justCopied = true
            Task {
                try? await Task.sleep(for: .seconds(1))
                justCopied = false
            }
        } label: {
            if labeled {
                Label(justCopied ? "Copied" : "Copy All", systemImage: justCopied ? "checkmark" : "doc.on.doc.fill")
            } else {
                Image(systemName: justCopied ? "checkmark" : "doc.on.doc")
                    .font(.caption)
            }
        }
        .buttonStyle(.plain)
        .foregroundStyle(justCopied ? .green : .secondary)
        .help(labeled ? "Copy entire transcript" : "Copy this message")
    }
}
