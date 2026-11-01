// ClaudeParser — Claude Code session jsonl. Line owns type=user|assistant + message.
// Drop this folder to add/remove the dialect; do not list it in ParseJSONLTranscript.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

struct ClaudeParser: JSONLLineParser {}                  // behavior: +Recognizes and +Parse
