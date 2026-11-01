// TOMLSubsetReader+Store — record one key in current section.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

extension TOMLSubsetReader {
    mutating func store(_ key: String, _ value: String) {
        sections[section, default: [:]][key] = value
    }
}
