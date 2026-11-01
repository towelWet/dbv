// AppDelegate+DidFinishLaunching — attach state, open launch document, ensure a window.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import AppKit

extension AppDelegate {
    @MainActor
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)            // SwiftPM-built GUI executables don't get .regular by default
        // onAppear (which used to hand the state to this delegate) never fires when the
        // WindowGroup window fails to appear, so attach the shared state here instead.
        state = AppState.shared
        var openedADocument = false
        for url in openedDocumentsFromAppleEvent() + openedDocumentsFromArguments() {
            openURL(url)                               // queues the doc; adoptPendingIfAttached now has a state
            openedADocument = true
            break
        }
        adoptPendingIfAttached()                       // apply the queued folder/file (sets browserRoot/mode)
        if !openedADocument, case .browser = AppState.shared.mode {
            AppState.shared.loadBrowser()              // plain launch: populate the default browser
        }
        ensureViewerWindow(state: AppState.shared)     // create an AppKit window if the WindowGroup never produced one
        NSApp.activate(ignoringOtherApps: true)        // bring DBV to the front
    }
}
