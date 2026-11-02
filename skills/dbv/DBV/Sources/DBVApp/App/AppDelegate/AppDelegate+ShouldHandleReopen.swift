// AppDelegate+ShouldHandleReopen — Dock click must not spawn a second empty window.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import AppKit

extension AppDelegate {
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if let window = sender.windows.first(where: { $0.canBecomeMain }) {
            window.makeKeyAndOrderFront(nil)
        }
        return false
    }
}
