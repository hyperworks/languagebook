import Foundation

// TODO: By allowing each Word to contains have an associated frame we are actually getting in the
//   way of the line-breaking algorithm. For example, words that got broken (hyphenated) onto two
//   lines would actually have a non-contiguous frame.
class Word: Media {
    typealias IndexType = Int
    typealias RangeType = ClosedInterval<IndexType>
    
    let text: String
    let sourceText: NSAttributedString
    let rangeInSourceText: RangeType
    
    init(frame: FrameType, sourceText: NSAttributedString, range: RangeType, interval: IntervalType) {
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
        super.init(frame: frame, interval: interval, children: [])
    }
    
}
