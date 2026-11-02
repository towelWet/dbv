// StarButton — toggle a turn's star. Writes through AppState.updateAnnotation, which
// persists to the .dbv.toml sidecar (never the .jsonl).
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI

struct StarButton: View {
    @Bindable var state: AppState
    let uuid: String

    private var isStarred: Bool { state.notes.record(for: uuid).starred }

    var body: some View {
        Button {
            state.updateNote(uuid: uuid) { $0.starred.toggle() }
        } label: {
            Image(systemName: isStarred ? "star.fill" : "star")
                .font(.caption)
        }
        .buttonStyle(.plain)
        .foregroundStyle(isStarred ? .yellow : .secondary)
        .help(isStarred ? "Unstar this turn" : "Star this turn")
    }
}
