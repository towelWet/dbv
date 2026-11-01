// CursorParser — Cursor IDE agent-transcript jsonl. Line owns role=user|assistant
// and a message dict, with no Claude-style top-level type. Status/error lines
// carry type without role and are ignored. Do not rewrite dumps to look like Claude.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

struct CursorParser: JSONLLineParser {}                  // behavior: +Recognizes and +Parse
