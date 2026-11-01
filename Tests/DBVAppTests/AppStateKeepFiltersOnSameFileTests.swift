// AppStateKeepFiltersOnSameFileTests — Finder re-opening same file keeps search.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import Testing
@testable import DBVApp

@Test @MainActor func adoptSameSingleFileKeepsSearchText() {
    let state = AppState()
    state.searchText = "keep_this"
    let url = URL(fileURLWithPath: "/tmp/s-1791587830137.jsonl")
    state.mode = .singleFile(url)
    state.adoptDocumentOpen(
        DocumentOpenPrepared(displayURL: url, scopeURL: url, scopeActive: false, prefetchedText: nil))
    #expect(state.searchText == "keep_this")
}
