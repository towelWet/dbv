// GodParseBoxFlushText — flush accumulated kind:text into one assistant turn.
import Foundation

func godParseBoxFlushText(_ box: GodParseBox) {
    let t = box.textBuf.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !t.isEmpty else { box.textBuf = ""; box.textTs = nil; return }
    box.pending.append(JSONLMessage(id: "god-\(box.textStart)", role: "assistant", text: t, timestamp: box.textTs))
    box.textBuf = ""
    box.textTs = nil
}
