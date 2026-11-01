// AppDelegate+OpenURLs — Finder hands over URLs: open first.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import AppKit

extension AppDelegate {
    func application(_ application: NSApplication, open urls: [URL]) {
        guard let url = urls.first else { return }
        openURL(url)
    }
}
