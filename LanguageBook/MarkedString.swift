import UIKit

class MarkedString {
    let script: NSTextStorage
    let portions: [TextPortion]
    let audioPath: String
    
    convenience init(script: String, audioPath: String, portions: [TextPortion]) {
        self.init(script: NSTextStorage(string: script),
            audioPath: audioPath,
            portions: portions)
    }
    
    convenience init(script: NSAttributedString, audioPath: String, portions: [TextPortion]) {
        self.init(script: NSTextStorage(attributedString: script),
            audioPath: audioPath,
            portions: portions)
    }
    
    init(script: NSTextStorage, audioPath: String, portions: [TextPortion]) {
        self.script = script
        self.audioPath = audioPath
        self.portions = portions
    }
    

    // TODO: We could store the portions in a SegmentTree<T> for super fast search. This will also
    //   allow us to find the nearest thing given a random spot as well, for example text portion
    //   nearest a certain point in time (if we ever need to support audio seeking)
    func textPortionAtCharacterIndex(index: Int) -> TextPortion? {
        var acc = 0
        let str = script.string!

        let idx = advance(str.startIndex, index)
        for portion in portions {
            if portion.wordSpan ~= idx { return portion }
        }
    
        return nil
    }
    
    func wordAtCharacterIndex(index: Int) -> String? {
        return textPortionAtCharacterIndex(index)?.wordInString(script)
    }


    func highlightPortion(portion: TextPortion) {
        // TODO: We need to calculate the original range span on the script itself, not the backing
        //   string, since NSAttributedString may modify the length of the string depending on the
        //   font being applied. (i.e. some font missing some glyphs and thus the number of
        //   characters can vary)
        let start = distance(script.string!.startIndex, portion.wordSpan.start)
        let length = distance(portion.wordSpan.start, portion.wordSpan.end)
        let range = NSRange(location: start, length: length)
        
        var attr = script.attributesAtIndex(0, effectiveRange: nil)
        attr[NSForegroundColorAttributeName] = UIColor.yellowColor()
        script.setAttributes(attr, range: range)
    }

    func removeAllHighlights() {
        let range = NSRange(location: 0, length: script.length)

        var attr = script.attributesAtIndex(0, effectiveRange: nil)
        attr[NSForegroundColorAttributeName] = UIColor.whiteColor()
        script.setAttributes(attr, range: range)
    }
}
