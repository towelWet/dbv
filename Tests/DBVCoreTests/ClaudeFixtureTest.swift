// ClaudeFixtureTest — synthetic Claude Code dump parses into two turns.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import Testing
@testable import DBVCore

@Test func claudeFixtureYieldsTwoTurns() throws {
    let url = try fixture("claude-one-turn")
    let messages = parseJSONLTranscript(url: url)
    #expect(messages.count == 2)
    #expect(messages[0].role == "user")
    #expect(messages[0].text.contains("hello claude"))
    #expect(messages[1].role == "assistant")
}
