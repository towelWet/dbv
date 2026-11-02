// DBVApp+Commands — File → Open God log via NSOpenPanel (~/.god/logs grant).
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import SwiftUI

extension DBVApp {
    @CommandsBuilder
    static func fileCommands(state: AppState) -> some Commands {
        CommandGroup(replacing: .newItem) { }
        CommandGroup(after: .newItem) {
            Button("Open God Log…") {
                let preferred = state.godLogOpenPreferredURL
                let hint = preferred?.lastPathComponent ?? ""
                state.openGodLogViaPanel(suggestedName: hint, preferredFileURL: preferred)
            }
                .keyboardShortcut("o", modifiers: [.command])
        }
    }
}
