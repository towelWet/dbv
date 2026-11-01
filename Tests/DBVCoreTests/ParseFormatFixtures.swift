// ParseFormatFixtures — known-good lines for each dropped format parser.
// Fixtures are synthetic, labeled as such. Real dumps are read-only when present.
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

@Test func cursorFixtureYieldsTwoTurnsAndSkipsStatus() throws {
    let url = try fixture("cursor-one-turn")
    let messages = parseJSONLTranscript(url: url)
    #expect(messages.count == 2)
    #expect(messages[0].role == "user")
    #expect(messages[0].text.contains("hello cursor"))
    #expect(messages[1].text.contains("hi from cursor"))
}

private func fixture(_ name: String) throws -> URL {
    try #require(Bundle.module.url(forResource: name, withExtension: "jsonl", subdirectory: "Fixtures"))
}
