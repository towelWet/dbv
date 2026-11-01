// EmptyTranscriptView — shown after a jsonl opened and zero turns parsed.
// The previous UI was a white pane with a search box (looked like a blank file).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import SwiftUI

struct EmptyTranscriptView: View {
    let filename: String
    let parsedCount: Int
    let readFailed: Bool
    let sourceLineCount: Int

    var body: some View {
        ContentUnavailableView {
            Label(readFailed ? "Could not read file" : "No turns parsed",
                  systemImage: "doc.text")
        } description: {
            Text(descriptionText)
        }
    }

    private var descriptionText: String {
        if readFailed {
            return "\(filename)\nFinder-open grant failed. Reopen the file after rebuild. Do not rewrite the jsonl."
        }
        return "\(filename)\nread \(sourceLineCount) lines, parsed \(parsedCount) turns. If this is a Cursor dump, quit DBV and reopen after rebuild. Do not rewrite the jsonl."
    }
}
