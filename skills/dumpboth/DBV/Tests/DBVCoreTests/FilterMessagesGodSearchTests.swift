// FilterMessagesGodSearchTests — documents the t78 blank-window symptom: parsed turns
// exist but a stale partial search ("mmer" from "scammer") hides every bubble.
import Foundation
import Testing
@testable import DBVCore

@Test func godT78UserPromptHasNoMmerSubstring() throws {
    let line =
        """
        {"kind":"user","seq":0,"text":"Find the password that the macOS app /Applications/Sample.app accepts. Reverse engineer its binary yourself and state the password clearly. Tools available: use the 'disasm' tool with binary+symbol to get a single function's disassembly (smaller than otool on the whole binary), and the 'swift_string' tool to decode a Swift small string from two movabsq immediates.","ts":1791587835115}
        """
    let obj = try #require(JSONSerialization.jsonObject(with: Data(line.utf8)) as? [String: Any])
    let parser = GodParser()
    let userTurn = try #require(parser.parse(obj, lineIndex: 0))
    let staleSearch = "mmer"
    let visible = filterMessages([userTurn], search: staleSearch, starredOnly: false, notes: NoteBook())
    #expect(visible.isEmpty)
}

@Test func filterMessagesEmptySearchShowsAllTurns() throws {
    let url = try #require(
        Bundle.module.url(forResource: "god-one-turn", withExtension: "jsonl", subdirectory: "Fixtures"))
    let messages = parseJSONLTranscript(url: url)
    #expect(!messages.isEmpty)
    let visible = filterMessages(messages, search: "", starredOnly: false, notes: NoteBook())
    #expect(visible.count == messages.count)
}
