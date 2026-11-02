// GodLogReadFixtures — optional read via DBV_GOD_LOG_PATH (no hardcoded session id).
import Foundation
import Testing
@testable import DBVCore

@Test func godLogReadWhenEnvironmentPathPresent() {
    guard let url = GodLogEnvironmentURL.resolved(),
          FileManager.default.isReadableFile(atPath: url.path) else { return }
    let result = loadJSONLTranscript(url: url)
    #expect(result.readFailed == false)
    #expect(result.sourceLineCount > 0)
    #expect(result.messages.isEmpty == false)
}
