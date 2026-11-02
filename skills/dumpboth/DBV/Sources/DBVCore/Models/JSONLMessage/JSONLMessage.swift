// JSONLMessage — one rendered turn in DBV's transcript view. Metadata fields below are
// all READ from the jsonl (never written back): timestamp, usage token counts, and the
// top-level attributionSkill / isApiErrorMessage / toolDenialKind flags that a real dump
// already carries. Human-authored data (notes/stars) is deliberately NOT here — it lives
// in the sidecar (see Sidecar/) and is joined by uuid at render time.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public struct JSONLMessage: Identifiable, Sendable {
    public let id: String       // the line's own uuid — also the sidecar annotation key
    public let role: String     // "user" | "assistant" | "tool_call" | "tool_result"
    public let text: String     // human-readable rendering (text blocks joined, tool calls described)
    public let timestamp: String?
    public let thinking: String?    // extended-thinking text, shown collapsed
    public let skill: String?       // top-level attributionSkill, when a skill drove the turn
    public let cacheReadTokens: Int?
    public let outputTokens: Int?
    public let isError: Bool        // top-level isApiErrorMessage
    public let isDenied: Bool       // top-level toolDenialKind — where the user rejected a tool call

    public init(
        id: String, role: String, text: String, timestamp: String?,
        thinking: String? = nil, skill: String? = nil,
        cacheReadTokens: Int? = nil, outputTokens: Int? = nil,
        isError: Bool = false, isDenied: Bool = false
    ) {
        self.id = id
        self.role = role
        self.text = text
        self.timestamp = timestamp
        self.thinking = thinking
        self.skill = skill
        self.cacheReadTokens = cacheReadTokens
        self.outputTokens = outputTokens
        self.isError = isError
        self.isDenied = isDenied
    }
}
