// ContentView — the mode switch. Browser mode: NavigationSplitView with the dump
// sidebar. Single-file mode: just the transcript, full window, no sidebar — the
// user's explicit requirement for files opened outside the dumpboth browser.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI
import DBVCore

struct ContentView: View {
    @Bindable var state: AppState

    var body: some View {
        switch state.mode {
        case .browser:
            NavigationSplitView {
                SidebarView(state: state)
                    .navigationSplitViewColumnWidth(min: 320, ideal: 400, max: 560)
            } detail: {
                if let pair = state.selected, let jsonlURL = pair.jsonlURL {
                    TranscriptView(state: state, title: pair.displayName, jsonlURL: jsonlURL)
                } else {
                    ContentUnavailableView("Select a dump", systemImage: "doc.text.magnifyingglass")
                }
            }
        case .singleFile(let url):
            TranscriptView(state: state, title: url.lastPathComponent, jsonlURL: url)
        }
    }
}
