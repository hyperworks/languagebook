import Foundation

extension NSRange {
    init(range: ClosedInterval<Int>) {
        self.init(location: range.start, length: (range.end - range.start))
    }

    func toStringRange(inString string: String) -> Range<String.Index> {
        let start = advance(string.startIndex, location)
        let end = advance(start, length)
        return Range(start: start, end: end)
    }
}
