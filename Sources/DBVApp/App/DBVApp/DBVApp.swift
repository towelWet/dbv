// DBVApp — entry point. WindowGroup shows the viewer; extras are closed on appear.
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI

@main
struct DBVApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @State private var state = AppState.shared   // same instance the AppDelegate's fallback window uses

    var body: some Scene {
        WindowGroup {
            ContentView(state: state)
                .onAppear {
                    appDelegate.attach(state: state)
                    if case .browser = state.mode { state.loadBrowser() }
                    closeExtraDBVWindows()
                }
                .onOpenURL { url in
                    appDelegate.openURL(url)
                }
        }
        .defaultSize(width: 1100, height: 800)
        .commands { DBVApp.fileCommands(state: state) }
    }
}
