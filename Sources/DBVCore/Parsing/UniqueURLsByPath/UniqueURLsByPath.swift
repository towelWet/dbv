// UniqueURLsByPath — drop URLs repeating an earlier path, keeping order.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func uniqueURLsByPath(_ urls: [URL]) -> [URL] {
    var seen = Set<String>()
    return urls.filter { seen.insert($0.path).inserted }
}
