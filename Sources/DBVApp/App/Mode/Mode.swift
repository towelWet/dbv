// Mode — the two ways DBV can be looking at the world.
// WHY BOTH EXIST: launching DBV itself (Dock/Applications) is "show me everything I've
// dumped" — the overview browser. Opening ONE jsonl (Finder double-click, "Open With",
// or as DBV registered as the system default .jsonl handler) is "show me just this
// file" — no sidebar, no browsing, just a clean read of that one transcript. This is
// a deliberate user requirement, not a simplification to walk back later.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

enum Mode {
    case browser
    case singleFile(URL)
}
