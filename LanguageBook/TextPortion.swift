import UIKit

// Needs to be a full class since we can't pass structs to protocols marked @objc
//   (which is effectively all protocols until Apple rewrites everything into Swift)
class TextPortion: NSObject {
    let wordSpan: HalfOpenInterval<String.Index>
    let timeSpan: HalfOpenInterval<Double>

    convenience init(fromIndex startIndex: String.Index,
        toIndex endIndex: String.Index,
        fromTime startTime: Double,
        toTime endTime: Double) {
            self.init(wordSpan: startIndex..<endIndex, timeSpan: startTime..<endTime)
    }

    init(wordSpan: HalfOpenInterval<String.Index>, timeSpan: HalfOpenInterval<Double>) {
        self.wordSpan = wordSpan
        self.timeSpan = timeSpan
    }


    func wordInString(str: NSAttributedString) -> String {
        return wordInString(str.string!)
    }

    func wordInString(s: String) -> String {
        return s.substringWithRange(Range(start: wordSpan.start, end: wordSpan.end))
    }
}
