// GodLogEnvironmentURL — optional integration path via DBV_GOD_LOG_PATH (no baked-in session id).
import Foundation

enum GodLogEnvironmentURL {
    static func resolved() -> URL? {
        guard let raw = ProcessInfo.processInfo.environment["DBV_GOD_LOG_PATH"],
              !raw.isEmpty else { return nil }
        return URL(fileURLWithPath: raw)
    }
}
