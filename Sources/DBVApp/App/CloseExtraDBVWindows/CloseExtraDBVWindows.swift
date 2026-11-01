// CloseExtraDBVWindows — drop WindowGroup clones after the first real viewer exists.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import AppKit

@MainActor
func closeExtraDBVWindows() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        let windows = NSApp.windows.filter {
            $0.isVisible && $0.canBecomeMain && $0.frame.height > 200
        }
        guard windows.count > 1 else { return }
        for window in windows.dropFirst() { window.close() }
        windows.first?.makeKeyAndOrderFront(nil)
    }
}
