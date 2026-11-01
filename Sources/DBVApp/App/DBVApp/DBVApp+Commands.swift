// DBVApp+Commands — disable the "New" menu item; DBV opens dumps via Finder / open -a.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import SwiftUI

extension DBVApp {
    @CommandsBuilder
    static func fileCommands(state: AppState) -> some Commands {
        CommandGroup(replacing: .newItem) { }   // DBV creates nothing; it only views existing dumps
    }
}
