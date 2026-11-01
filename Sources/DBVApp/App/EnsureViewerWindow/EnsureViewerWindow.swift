// EnsureViewerWindow — guarantee a visible viewer window exists, whatever SwiftUI did.
// WHY IT EXISTS: in some launch contexts the SwiftUI WindowGroup never produces a visible
// window — it comes up as a titlebar-height strip pinned off-screen, and onAppear never
// fires. When that happens we host ContentView in an explicit AppKit NSWindow so the viewer
// is always usable (and screenshot-able). It fires on a short delay and only when no healthy
// WindowGroup window has appeared, so a normal launch (where WindowGroup works) never gets a
// duplicate window. One function per file — sibling of CloseExtraDBVWindows.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import AppKit
import SwiftUI

@MainActor private var dbvFallbackWindow: NSWindow?   // retained so the hosted window isn't deallocated

@MainActor
func ensureViewerWindow(state: AppState) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {   // give a working WindowGroup time to appear first
        // a healthy viewer window is tall and sits on a real screen
        let healthy = NSApp.windows.contains { w in
            w.canBecomeMain && w.frame.height > 200 &&
            NSScreen.screens.contains { $0.visibleFrame.intersects(w.frame) }
        }
        if healthy { return }                                 // WindowGroup worked → nothing to do
        if let existing = dbvFallbackWindow {                 // already built one → just surface it
            existing.makeKeyAndOrderFront(nil)
            return
        }
        let host = NSHostingController(rootView: ContentView(state: state))
        let window = NSWindow(contentViewController: host)
        window.title = "DBV — Dumps"
        window.styleMask = [.titled, .closable, .miniaturizable, .resizable]
        window.setContentSize(NSSize(width: 1100, height: 760))
        window.center()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        dbvFallbackWindow = window
    }
}
