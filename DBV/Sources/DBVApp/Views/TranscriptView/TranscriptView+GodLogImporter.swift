// TranscriptView+GodLogImporter — NSOpenPanel at ~/.god/logs when scoped read fails.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import DBVCore

extension TranscriptView {
    /// Blocks on `NSOpenPanel` (Finder grant). Returns true when user picked a log.
    func offerGodLogPanelIfNeeded(readFailed: Bool) async -> Bool {
        guard readFailed, isGodLogSessionBasename(jsonlURL.lastPathComponent) else { return false }
        let path = jsonlURL.path
        let name = jsonlURL.lastPathComponent
        guard AppState.godLogOpenPanelInFlight == false else { return false }
        guard await MainActor.run(body: { state.godLogPickerOfferedPath != path }) else { return false }
        AppState.godLogOpenPanelInFlight = true
        defer { AppState.godLogOpenPanelInFlight = false }
        guard let picked = await presentGodLogOpenPanel(suggestedName: name, preferredFileURL: jsonlURL) else { return false }
        guard picked.lastPathComponent == name else { return false }
        await MainActor.run {
            state.godLogPickerOfferedPath = path
            state.applyPickedGodLogURL(picked)
        }
        return true
    }
}
