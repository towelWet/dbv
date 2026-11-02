// CopyToClipboard — one shared clipboard-write helper for the copy buttons in
// MessageBubbleView (copy one turn) and TranscriptView (copy the whole transcript).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import AppKit

func copyToClipboard(_ text: String) {
    let pb = NSPasteboard.general
    pb.clearContents()                                // must clear before setString, else it appends as a second item
    pb.setString(text, forType: .string)
}
