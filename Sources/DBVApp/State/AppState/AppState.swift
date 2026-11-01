// AppState — single source of truth for DBV's mode: browser (all dumps, sidebar) vs
// single-file (one jsonl opened directly, no sidebar). See ../App/Mode.swift for why
// the mode split exists. Declaration ONLY — each method lives in its own extension
// file in this folder one function per file.
// `sidecar` holds the HUMAN layer (notes/markers/stars) loaded from the .dbv.toml
// companion; the .jsonl itself is never mutated.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import Observation
import DBVCore

@Observable
@MainActor
final class AppState {
    /// Shared instance so the AppKit fallback window (EnsureViewerWindow) and the SwiftUI
    /// WindowGroup render the SAME state. Needed because onAppear — where state used to be
    /// handed to the AppDelegate — never fires when the WindowGroup window fails to appear.
    static let shared = AppState()

    var mode: Mode = .browser
    var pairs: [DumpPair] = []
    /// List selection is the pair `id` (Int). Binding `DumpPair?` ignores clicks on macOS.
    var selectedID: Int?
    var selected: DumpPair? {
        get { pairs.first(where: { $0.id == selectedID }) }
        set { selectedID = newValue?.id }
    }
    /// Folder LS / `open -a DBV` handed us; nil means the default `~/Old Chats` browser.
    var browserRoot: URL?

    // Human note layer for whichever transcript is currently open. Lives in the
    // skill db (db/<dump>/<uuid>.toml), never inside the .jsonl.
    var notes = NoteBook()
    var notesJSONL: URL?            // which .jsonl the loaded NoteBook belongs to

    // View controls
    var searchText = ""
    var starredOnly = false
    var noteEditingUUID: String?    // which turn's note composer is open (nil = none)
    var showTimeline = false        // notes timeline inspector visible
    var jumpTarget: String?         // one-shot scroll request from the timeline

    // Security-scoped access for a jsonl opened via LaunchServices (Finder / open -a).
    var fileScopeURL: URL?
    var fileScopeActive = false
    var prefetchedJSONLText: String?
    var prefetchedJSONLName: String?
}
