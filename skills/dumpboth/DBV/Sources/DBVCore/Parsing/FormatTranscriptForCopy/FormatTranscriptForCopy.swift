// FormatTranscriptForCopy — render a whole [JSONLMessage] list as plain text for the
// "Copy All" toolbar button. Split out per /split-files so TranscriptView stays a
// pure view and this stays a pure, independently-testable formatter.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func formatTranscriptForCopy(_ messages: [JSONLMessage]) -> String {
    messages
        .map { message in
            let speaker = jsonlRoleLabel(message.role)
            return "\(speaker):\n\(message.text)"
        }
        .joined(separator: "\n\n")
}
