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

    @MainActor
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)            // SwiftPM-built GUI executables don't get .regular by default → no visible window; force it
        // onAppear (which used to hand the state to this delegate) never fires when the
        // WindowGroup window fails to appear, so attach the shared state here instead.
        state = AppState.shared
        var openedADocument = false
        for url in openedDocumentsFromAppleEvent() + openedDocumentsFromArguments() {
            openURL(url)                               // queues the doc; adoptPendingIfAttached now has a state to adopt into
            openedADocument = true
            break
        }
        adoptPendingIfAttached()                       // apply the queued folder/file (sets browserRoot/mode + loadBrowser)
        if !openedADocument, case .browser = AppState.shared.mode {
            AppState.shared.loadBrowser()              // plain launch: populate the default ~/Old Chats browser
        }
        ensureViewerWindow(state: AppState.shared)     // create an AppKit window if the WindowGroup never produced a visible one
        NSApp.activate(ignoringOtherApps: true)        // bring DBV to the front
    }
}
