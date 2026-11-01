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
}
