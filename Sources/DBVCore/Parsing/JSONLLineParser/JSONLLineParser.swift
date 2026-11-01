// JSONLLineParser — one jsonl dialect. Each format owns its own file under Formats/.
// This protocol is the contract only. No format names live here.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

protocol JSONLLineParser: Sendable {
    func recognizes(_ obj: [String: Any]) -> Bool
    func parse(_ obj: [String: Any], lineIndex: Int) -> JSONLMessage?
}
