import Foundation

class Word: Media {
    typealias IndexType = Int
    typealias RangeType = ClosedInterval<IndexType>
    
    let text: String
    let sourceText: NSAttributedString
    let rangeInSourceText: RangeType
    
    init(sourceText: NSAttributedString, range: RangeType, interval: IntervalType) {
        // TODO: This is actually wrong since attributed string's index does not account for unicode
        //   character merges. We'll have to wait until NSAttributedString is converted to properly
        //   use the new String.Index system before we can do anything about this short of handling
        //   unicode by ourselves.
        let str = sourceText.string
        let wordRange = Range(start: advance(str.startIndex, range.start),
            end: advance(str.startIndex, range.end))
        
        self.text = str.substringWithRange(wordRange)
        self.sourceText = sourceText
        self.rangeInSourceText = range
        super.init(interval: interval, children: [])
    }
    
}
