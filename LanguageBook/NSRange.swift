import Foundation

extension NSRange {
    func toStringRange(inString string: String) -> Range<String.Index> {
        let start = advance(string.startIndex, location)
        let end = advance(start, length)
        return Range(start: start, end: end)
    }
}
