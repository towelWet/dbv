// JSONLRoleLabel — bubble / copy header for a parsed turn.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func jsonlRoleLabel(_ role: String) -> String {
    switch role {
    case "user": return "You"
    case "tool_call": return "tool_call"
    case "tool_result", "tool": return "tool_result"
    default: return "Assistant"
    }
}
