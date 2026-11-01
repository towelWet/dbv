// FixtureURL — locate named synthetic jsonl fixture in test bundle.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import Testing

func fixture(_ name: String) throws -> URL {
    try #require(Bundle.module.url(forResource: name, withExtension: "jsonl", subdirectory: "Fixtures"))
}
