// PresentGodLogOpenPanelNow — modal grant; preselect basename only from open document URL.
import AppKit
import DBVOpenPanelModal
import UniformTypeIdentifiers

@MainActor
func presentGodLogOpenPanelNow(suggestedName: String, preferredFileURL: URL? = nil) -> URL? {
    let panel = makeGodLogNSOpenPanel()
    let target = godLogOpenTargetURL(preferredFileURL: preferredFileURL, suggestedName: suggestedName)
    let response: NSApplication.ModalResponse
    if let target, let name = target.basename {
        response = DBVRunOpenPanelPreselecting(panel, target.directory.path, name)
    } else {
        panel.allowedContentTypes = [UTType(filenameExtension: "jsonl") ?? .plainText]
        response = panel.runModal()
    }
    guard response == .OK, let url = panel.url else { return nil }
    if let expected = target?.basename, url.lastPathComponent != expected { return nil }
    return url
}
