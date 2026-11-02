// PresentGodLogOpenPanel — async wrapper (SwiftUI .task timing).
import AppKit

@MainActor
func presentGodLogOpenPanel(suggestedName: String, preferredFileURL: URL? = nil) async -> URL? {
    await withCheckedContinuation { cont in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            Task { @MainActor in
                cont.resume(returning: presentGodLogOpenPanelNow(
                    suggestedName: suggestedName,
                    preferredFileURL: preferredFileURL
                ))
            }
        }
    }
}
