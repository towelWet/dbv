// ScanDumpPairs — walk a directory once and group oldchatN[-tag].{md,jsonl} into
// DumpPairs. Per-filename parsing lives in ParseDumpFilename.swift; the accumulator
// shape lives in DumpSlot.swift — this file is just the walk-and-assemble loop.
// WHY IT EXISTS: the same grouping logic dumpboth's Python detect/scan_pairs.py
// performs for the CLI, reimplemented natively so the app has no Python dependency.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

public func scanDumpPairs(in directory: URL) -> [DumpPair] {
    let fm = FileManager.default
    guard let entries = try? fm.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil) else {
        return []
    }

    var slots: [Int: DumpSlot] = [:]
    for url in entries {
        guard let parsed = parseDumpFilename(url) else { continue }
        var slot = slots[parsed.number] ?? DumpSlot(tag: nil, md: nil, jsonl: nil)
        if parsed.ext == "md" { slot.md = url } else { slot.jsonl = url }
        if parsed.tag != nil { slot.tag = parsed.tag }    // keep whichever file carried a real tag
        slots[parsed.number] = slot
    }

    return slots.keys.sorted(by: >).map { number in        // newest dump first
        let slot = slots[number]!
        let label = slot.tag.map { "oldchat\(number) — \($0)" } ?? "oldchat\(number)"
        return DumpPair(id: number, tag: slot.tag, displayName: label, mdURL: slot.md, jsonlURL: slot.jsonl)
    }
}
