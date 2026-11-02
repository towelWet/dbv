// ScanJSONLSessionsFixtures — s-*.jsonl folder listing for God archive browse.
import Foundation
import Testing
@testable import DBVCore

@Test func scanJSONLSessionsListsGodBasenames() throws {
    let dir = FileManager.default.temporaryDirectory
        .appendingPathComponent("dbv-god-scan-\(UUID().uuidString)", isDirectory: true)
    try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
    defer { try? FileManager.default.removeItem(at: dir) }
    let jsonl = dir.appendingPathComponent("s-1790000000001.jsonl")
    try Data("{\"kind\":\"user\",\"text\":\"hi\"}\n".utf8).write(to: jsonl)
    try Data("nope".utf8).write(to: dir.appendingPathComponent("oldchat1.jsonl"))
    let pairs = scanJSONLSessions(in: dir)
    #expect(pairs.count == 1)
    #expect(pairs[0].displayName == "s-1790000000001")
    #expect(pairs[0].jsonlURL?.lastPathComponent == "s-1790000000001.jsonl")
    #expect(pairs[0].mdURL == nil)
    #expect(pairs[0].preview == "hi")
}
