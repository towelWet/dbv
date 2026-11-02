// AppDelegate — Finder / open -a deliver jsonl via NSApplicationDelegate (not .onDrop).
// Do not mark @MainActor: SwiftUI adaptor skips delegate callbacks when the class is.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate, @unchecked Sendable {
    override init() {
        super.init()
        installOpenDocumentsAppleEventHandler()
    }

    var state: AppState?
    nonisolated(unsafe) var pendingDocumentOpen: DocumentOpenPrepared?
    var lastOpenPath: String?
    var lastOpenTime: Date = .distantPast

    func application(_ application: NSApplication, open urls: [URL]) {
        guard let url = urls.first else { return }
        openURL(url)
    }

    func application(_ sender: NSApplication, openFiles filenames: [String]) {
        guard let first = filenames.first else { return }
        openURL(URL(fileURLWithPath: first))
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        for url in openedDocumentsFromAppleEvent() + openedDocumentsFromArguments() {
            openURL(url)
            return
        }
    }
}
