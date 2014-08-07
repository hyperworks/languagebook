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
    

    // TODO: We could store the portions in a BinaryTree<T> for super fast search. This will also
    //   allow us to find the nearest thing given a random spot as well, for example text portion
    //   nearest a certain point in time (if we ever need to support audio seeking)
    func textPortionAtCharacterIndex(index: Int) -> TextPortion? {
        var acc = 0
        let str = script.string!
        
        // TODO: There was no way to safely compare String.Index so we have to resort to this.
        func compare(a: String.Index, b: String.Index, inString str: String) -> NSComparisonResult {
            if a == b { return .OrderedSame }
            
            var i = str.startIndex
            while i != str.endIndex {
                if i == a {
                    return .OrderedAscending
                } else if i == b {
                    return .OrderedDescending
                } else {
                    i = i.successor()
                }
            }
            
            // Should actually panic() here, but oh well...
            return .OrderedAscending
        }
        
        let idx = advance(str.startIndex, index)
        for portion in portions {
            if compare(portion.wordSpan.from, idx, inString: str) == .OrderedDescending { continue }
            if compare(portion.wordSpan.to, idx, inString: str) == .OrderedAscending { continue }
            
            return portion
        }
    
        return nil
    }
    
    func wordAtCharacterIndex(index: Int) -> String? {
        return textPortionAtCharacterIndex(index)?.wordInString(script)
    }
}
