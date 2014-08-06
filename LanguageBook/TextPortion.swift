import UIKit

// Needs to be a full class since we can't pass structs to protocols marked @objc
//   (which is effectively all protocols until Apple rewrites everything into Swift)
class TextPortion: NSObject {
    let wordSpan: Span<String.Index>
    let timeSpan: Span<Float>

    convenience init(fromIndex startIndex: String.Index, toIndex endIndex: String.Index,
        fromTime startTime: Float, toTime endTime: Float) {

        self.init(wordSpan: Span(from: startIndex, to: endIndex),
            timeSpan: Span(from: startTime, to: endTime))
    }

    init(wordSpan: Span<String.Index>, timeSpan: Span<Float>) {
        self.wordSpan = wordSpan
        self.timeSpan = timeSpan
    }


    func wordInString(str: NSAttributedString) -> String {
        return wordInString(str.string!)
    }

    func wordInString(s: String) -> String {
        return s.substringWithRange(Range(start: wordSpan.from, end: wordSpan.to))
    }
}
