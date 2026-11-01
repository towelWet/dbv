// DumpSlot — the per-number accumulator ScanDumpPairs.swift builds up while walking
// the directory, before it's finalized into public DumpPair values. Internal-only:
// this is scan-time scratch state, not part of DBVCore's public model.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

struct DumpSlot {
    var tag: String?
    var md: URL?
    var jsonl: URL?
}
