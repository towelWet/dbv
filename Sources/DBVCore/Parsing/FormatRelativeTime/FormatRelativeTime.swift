// FormatRelativeTime — turn the jsonl's ISO8601 `timestamp` into a short wall-clock
// label for a bubble. The field was already present on 1,293 lines of a real dump and
// was simply being ignored before this — pure display of data already in the file.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func formatClockTime(_ iso: String?) -> String? {
    guard let iso, let date = isoParser.date(from: iso) else { return nil }
    return clockFormatter.string(from: date)
}

// Parsers are expensive to construct — build once, reuse. `withFractionalSeconds` is
// required: Claude Code writes timestamps like 2026-08-18T06:15:04.023Z.
// `nonisolated(unsafe)` is correct rather than a dodge: both formatters are fully
// configured here at init and thereafter only READ (Foundation's date formatters are
// documented thread-safe for concurrent formatting once configured). Making them
// @MainActor instead would wrongly force main-thread hops during background parsing.
nonisolated(unsafe) private let isoParser: ISO8601DateFormatter = {
    let f = ISO8601DateFormatter()
    f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return f
}()

// (DateFormatter is already Sendable, so it needs no nonisolated(unsafe) — only the
// ISO8601DateFormatter above does.)
private let clockFormatter: DateFormatter = {
    let f = DateFormatter()
    f.dateFormat = "h:mm a"
    return f
}()
