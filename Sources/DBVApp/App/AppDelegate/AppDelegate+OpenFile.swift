// AppDelegate+OpenFile — older LS open path (filename string). Finder on some
// macOS versions delivers this instead of application(_:open:).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import AppKit

extension AppDelegate {
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        openURL(URL(fileURLWithPath: filename))
        return true
    }
}
