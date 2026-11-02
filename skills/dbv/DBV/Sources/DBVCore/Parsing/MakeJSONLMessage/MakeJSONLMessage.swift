// MakeJSONLMessage — shared turn constructor. Formats differ on how they *recognize*
// a line; once a message dict exists, body/meta rendering is the same.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func makeJSONLMessage(line obj: [String: Any], message: [String: Any], lineIndex: Int) -> JSONLMessage? {
    let (body, thinking) = renderMessageBody(message)
    guard !body.isEmpty || thinking != nil else { return nil }
    let meta = extractTurnMeta(line: obj, message: message)
    let role = (message["role"] as? String)
        ?? (obj["role"] as? String)
        ?? (obj["type"] as? String)
        ?? "assistant"
    return JSONLMessage(
        id: (obj["uuid"] as? String) ?? "line-\(lineIndex)",
        role: role,
        text: body,
        timestamp: obj["timestamp"] as? String,
        thinking: thinking,
        skill: meta.skill,
        cacheReadTokens: meta.cacheReadTokens,
        outputTokens: meta.outputTokens,
        isError: meta.isError,
        isDenied: meta.isDenied
    )
}
