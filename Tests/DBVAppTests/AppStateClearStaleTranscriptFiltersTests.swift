// AppStateClearStaleTranscriptFiltersTests — Finder opening another file must not keep prior search.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import Testing
@testable import DBVApp

@Test @MainActor func adoptNewSingleFileClearsSearchText() {
    let state = AppState()
    state.searchText = "err"
    state.starredOnly = true
    let first = URL(fileURLWithPath: "/tmp/s-1791653544718.jsonl")
    let second = URL(fileURLWithPath: "/tmp/s-1791587830137.jsonl")
    state.mode = .singleFile(first)
    state.adoptDocumentOpen(
        DocumentOpenPrepared(displayURL: second, scopeURL: second, scopeActive: false, prefetchedText: nil))
    #expect(state.searchText.isEmpty)
    #expect(state.starredOnly == false)
}
