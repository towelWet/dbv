// TurnMetaView — the small grey metadata line under a bubble's role label: wall-clock
// time, token cost, driving skill, and error/denial flags. Every value here was ALREADY
// in the jsonl and simply wasn't being shown before.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI
import DBVCore

struct TurnMetaView: View {
    let message: JSONLMessage

    var body: some View {
        HStack(spacing: 8) {
            if let clock = formatClockTime(message.timestamp) {
                Text(clock)
            }
            if let usage = formatTokenUsage(cacheRead: message.cacheReadTokens, output: message.outputTokens) {
                Text(usage)
            }
            if let skill = message.skill {
                Text("/\(skill)").foregroundStyle(.purple)
            }
            if message.isDenied {
                Text("denied").foregroundStyle(.orange)
            }
            if message.isError {
                Text("error").foregroundStyle(.red)
            }
        }
        .font(.caption2)
        .foregroundStyle(.secondary)
    }
}
