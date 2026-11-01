// AppDelegate+OpenFiles — older open path hands over file names: open first.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import AppKit

extension AppDelegate {
    func application(_ sender: NSApplication, openFiles filenames: [String]) {
        guard let first = filenames.first else { return }
        openURL(URL(fileURLWithPath: first))
    }
}
