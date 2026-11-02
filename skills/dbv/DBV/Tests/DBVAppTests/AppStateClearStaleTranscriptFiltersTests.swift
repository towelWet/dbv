// AppStateClearStaleTranscriptFiltersTests — Finder re-open must not keep prior search text.
import Foundation
import Testing
@testable import DBVApp

@Test @MainActor func adoptNewSingleFileClearsSearchText() {
    let state = AppState()
    state.searchText = "mmer"
    state.starredOnly = true
    let first = URL(fileURLWithPath: "/tmp/s-1791653544718.jsonl")
    let second = URL(fileURLWithPath: "/tmp/s-1791587830137.jsonl")
    state.mode = .singleFile(first)
    state.adoptDocumentOpen(
        DocumentOpenPrepared(displayURL: second, scopeURL: second, scopeActive: false, prefetchedText: nil))
    #expect(state.searchText.isEmpty)
    #expect(state.starredOnly == false)
}

@Test @MainActor func adoptSameSingleFileKeepsSearchText() {
    let state = AppState()
    state.searchText = "swift_string"
    let url = URL(fileURLWithPath: "/tmp/s-1791587830137.jsonl")
    state.mode = .singleFile(url)
    state.adoptDocumentOpen(
        DocumentOpenPrepared(displayURL: url, scopeURL: url, scopeActive: false, prefetchedText: nil))
    #expect(state.searchText == "swift_string")
}
