// OpenedDocumentsFromArguments — jsonl path argv when LS passes a shell-style launch.
// NEVER DELETE COMMENTS — explain every non-obvious line.
// Update comments with the code; do not strip them.
import Foundation
import DBVCore

func openedDocumentsFromArguments() -> [URL] {
    CommandLine.arguments.dropFirst().compactMap { arg in
        let url = URL(fileURLWithPath: arg)
        if arg.hasSuffix(".jsonl") { return url }
        return urlIsDirectory(url) ? url : nil
    }
}
