// AppState+ApplyPickedGodLog — panel/ File→Open URL: scope, bookmark, single-file mode.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import DBVCore

extension AppState {
    func applyPickedGodLogURL(_ url: URL) {
        _ = url.startAccessingSecurityScopedResource()
        saveGodLogSecurityBookmark(url: url)
        adoptDocumentOpen(prepareDocumentOpen(url))
    }

    func openGodLogViaPanel(suggestedName: String = "", preferredFileURL: URL? = nil) {
        guard let picked = presentGodLogOpenPanelNow(
            suggestedName: suggestedName,
            preferredFileURL: preferredFileURL
        ) else { return }
        applyPickedGodLogURL(picked)
    }

    func applyGodLogImporterURLs(_ urls: [URL]) -> URL? {
        guard let picked = urls.first else { return nil }
        applyPickedGodLogURL(picked)
        return picked
    }
}
