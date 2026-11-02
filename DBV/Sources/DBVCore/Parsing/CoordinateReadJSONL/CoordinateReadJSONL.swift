// CoordinateReadJSONL — NSFileCoordinator read (Finder / LS grant friendly).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func coordinateReadJSONL(url: URL) -> String? {
    let coordinator = NSFileCoordinator()
    var readError: NSError?
    var payload: String?
    coordinator.coordinate(readingItemAt: url, options: .withoutChanges, error: &readError) { readURL in
        guard let data = try? Data(contentsOf: readURL) else { return }
        payload = String(decoding: data, as: UTF8.self)
    }
    return payload
}
