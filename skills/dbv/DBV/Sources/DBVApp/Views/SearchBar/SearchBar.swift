// SearchBar — search box plus the starred-only toggle and a match count. Searching
// covers human notes as well as transcript text (see FilterMessages for why).
// NEVER DELETE COMMENTS — explain every non-obvious line.
import SwiftUI

struct SearchBar: View {
    @Bindable var state: AppState
    let total: Int
    let shown: Int

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
            TextField("Search transcript and notes", text: $state.searchText)
                .textFieldStyle(.plain)
            if shown != total {
                Text("\(shown)/\(total)").font(.caption).foregroundStyle(.secondary)
            }
            Toggle(isOn: $state.starredOnly) {
                Image(systemName: state.starredOnly ? "star.fill" : "star")
            }
            .toggleStyle(.button)
            .help("Show starred turns only")
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.bar)
    }
}
