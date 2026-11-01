// ParseDumpFilename — pull {number, tag, ext} out of one "oldchatN[-tag].{md,jsonl}"
// filename. Extracted from ScanDumpPairs.swift (was pushing that file past 50 lines)
// so the number/tag parsing rule lives in exactly one place, testable on its own.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation

struct ParsedDumpFilename {
    let number: Int
    let tag: String?      // nil unless the suffix is exactly 8 lowercase-hex chars (a real /dumpboth tag)
    let ext: String        // "md" or "jsonl"
}

func parseDumpFilename(_ url: URL) -> ParsedDumpFilename? {
    let name = url.lastPathComponent
    guard name.hasPrefix("oldchat") else { return nil }
    let ext = url.pathExtension
    guard ext == "md" || ext == "jsonl" else { return nil }

    let stem = String(name.dropLast(ext.count + 1))           // "oldchat42-b4f9a2c1"
    let afterPrefix = stem.dropFirst("oldchat".count)          // "42-b4f9a2c1"
    let digits = afterPrefix.prefix(while: { $0.isNumber })
    guard let number = Int(digits) else { return nil }

    var tag: String? = nil
    let rest = afterPrefix.dropFirst(digits.count)             // "-b4f9a2c1" or ""
    if rest.hasPrefix("-") {
        let suffix = String(rest.dropFirst())
        // /dumpboth tags are exactly 8 lowercase hex chars — a plain "-my-label"
        // suffix from a lone /dumpchat call won't match, so it's left untagged.
        if suffix.count == 8, suffix.allSatisfy({ ($0.isHexDigit && $0.isLowercase) || $0.isNumber }) {
            tag = suffix
        }
    }

    return ParsedDumpFilename(number: number, tag: tag, ext: ext)
}
