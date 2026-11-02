// GodFormatFixtures — god CLI session jsonl (`kind` events), not Claude/Cursor dumps.
import Foundation
import Testing
@testable import DBVCore

@Test func godFixtureYieldsTwoTurns() throws {
    let url = try godFixture("god-one-turn")
    let messages = parseJSONLTranscript(url: url)
    #expect(messages.count == 2)
    #expect(messages[0].role == "user")
    #expect(messages[0].text.contains("ping god"))
    #expect(messages[1].role == "assistant")
    #expect(messages[1].text.contains("pong from god"))
}

@Test func godToolsFixtureYieldsLabeledTurns() throws {
    let url = try godFixture("god-tools")
    let messages = parseJSONLTranscript(url: url)
    #expect(messages.count == 4)
    #expect(messages[0].role == "user")
    #expect(messages[1].role == "tool_call")
    #expect(messages[2].role == "tool_result")
    #expect(messages[3].role == "assistant")
    #expect(jsonlRoleLabel("user") == "You")
    #expect(jsonlRoleLabel("tool_call") == "tool_call")
    #expect(jsonlRoleLabel("tool_result") == "tool_result")
}

@Test func godLogIfPresentIsGodDialect() throws {
    guard let url = GodLogEnvironmentURL.resolved(),
          FileManager.default.isReadableFile(atPath: url.path) else { return }
    let line = try String(contentsOf: url, encoding: .utf8)
        .split(separator: "\n", omittingEmptySubsequences: true).first ?? ""
    let obj = try #require(JSONSerialization.jsonObject(with: Data(line.utf8)) as? [String: Any])
    #expect(GodParser().recognizes(obj))
    #expect(ClaudeParser().recognizes(obj) == false)
    #expect(CursorParser().recognizes(obj) == false)
}

private func godFixture(_ name: String) throws -> URL {
    try #require(Bundle.module.url(forResource: name, withExtension: "jsonl", subdirectory: "Fixtures"))
}
