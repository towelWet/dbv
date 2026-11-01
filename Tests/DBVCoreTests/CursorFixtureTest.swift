// CursorFixtureTest — synthetic Cursor dump parses into two turns, skipping status lines.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import Testing
@testable import DBVCore

@Test func cursorFixtureYieldsTwoTurnsAndSkipsStatus() throws {
    let url = try fixture("cursor-one-turn")
    let messages = parseJSONLTranscript(url: url)
    #expect(messages.count == 2)
    #expect(messages[0].role == "user")
    #expect(messages[0].text.contains("hello cursor"))
    #expect(messages[1].text.contains("hi from cursor"))
}
