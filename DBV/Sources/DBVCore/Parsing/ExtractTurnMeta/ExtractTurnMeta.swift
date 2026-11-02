// ExtractTurnMeta — pull the per-turn metadata out of one raw jsonl line object.
// Split from ParseJSONLTranscript so that parser stays a pure line-walking loop and this
// stays the one place that knows where each metadata field lives in the schema.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

struct TurnMeta {
    let skill: String?
    let cacheReadTokens: Int?
    let outputTokens: Int?
    let isError: Bool
    let isDenied: Bool
}

func extractTurnMeta(line obj: [String: Any], message: [String: Any]) -> TurnMeta {
    // usage lives on the assistant message; the two counts that actually explain cost
    // are cache_read (what was reused) and output (what was newly generated).
    let usage = message["usage"] as? [String: Any]
    return TurnMeta(
        skill: obj["attributionSkill"] as? String,
        cacheReadTokens: usage?["cache_read_input_tokens"] as? Int,
        outputTokens: usage?["output_tokens"] as? Int,
        isError: (obj["isApiErrorMessage"] as? Bool) ?? false,
        isDenied: obj["toolDenialKind"] != nil
    )
}
