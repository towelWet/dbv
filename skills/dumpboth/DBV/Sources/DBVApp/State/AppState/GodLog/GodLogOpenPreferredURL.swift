// GodLogOpenPreferredURL — panel preselect follows the jsonl already on screen.
import Foundation

extension AppState {
    var godLogOpenPreferredURL: URL? {
        if case .singleFile(let url) = mode { return url }
        if let notesJSONL { return notesJSONL }
        if let fileScopeURL { return fileScopeURL }
        return nil
    }
}
