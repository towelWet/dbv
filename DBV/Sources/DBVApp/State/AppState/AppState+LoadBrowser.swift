// AppState+LoadBrowser — one method, its own file (one function per file, literally).
// Grouped in the same AppState/ folder as the declaration + its other extension
// because both are the SAME type — a separate top-level folder per method would be
// the awkward kind of split, not the rational one.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import DBVCore

extension AppState {
    func loadBrowser() {
        let oldChats = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Old Chats")
        let scoped = browserRoot == nil ? resolveGodLogSecurityBookmark(basename: "Old Chats") : nil   // saved grant from an earlier folder-open
        _ = scoped?.startAccessingSecurityScopedResource()   // replay that grant so a cold launch can list the folder
        let root = browserRoot ?? scoped ?? oldChats
        pairs = scanDumpPairs(in: root) + scanJSONLSessions(in: root)
        selected = browserRoot == nil ? pairs.first : nil
    }
}
