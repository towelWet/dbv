// AbbreviateCount — 46841 -> "46.8k". Own file per /split-files "one function per file".
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

func abbreviateCount(_ n: Int) -> String {
    if n < 1000 { return "\(n)" }
    let thousands = Double(n) / 1000.0
    return String(format: "%.1fk", thousands)
}
