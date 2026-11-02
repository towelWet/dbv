// MakeGodLogNSOpenPanel — configure NSOpenPanel for ~/.god/logs grant.
import AppKit

@MainActor
func makeGodLogNSOpenPanel() -> NSOpenPanel {
    let panel = NSOpenPanel()
    panel.title = "Open God session log"
    panel.message = "Grant read access to a log under ~/.god/logs (symlink OK)."
    panel.canChooseFiles = true
    panel.canChooseDirectories = false
    panel.allowsMultipleSelection = false
    return panel
}
