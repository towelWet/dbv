// OpenedDocumentsFromAppleEvent — kAEOpenDocuments when SwiftUI skips delegate open.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import AppKit
import Foundation

func openedDocumentsFromAppleEvent() -> [URL] {
    guard let event = NSAppleEventManager.shared().currentAppleEvent,
          event.eventClass == kCoreEventClass,
          event.eventID == kAEOpenDocuments,
          let list = event.paramDescriptor(forKeyword: keyDirectObject)
    else { return [] }
    var urls: [URL] = []
    for index in 1...list.numberOfItems {
        guard let raw = list.atIndex(index)?.stringValue else { continue }
        urls.append(URL(fileURLWithPath: raw))
    }
    return urls
}
