// AppDelegate+HandleOpenDocuments — kAEOpenDocuments: scope + prepare in-event.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import AppKit
import Foundation

extension AppDelegate {
    @objc func handleOpenDocuments(_ event: NSAppleEventDescriptor,
                                   withReplyEvent reply: NSAppleEventDescriptor) {
        guard let list = event.paramDescriptor(forKeyword: keyDirectObject) else { return }
        for index in 1...list.numberOfItems {
            guard let raw = list.atIndex(index)?.stringValue else { continue }
            let url = URL(fileURLWithPath: raw)
            _ = url.startAccessingSecurityScopedResource()
            queuePreparedDocument(prepareDocumentOpen(url))
        }
    }
}
