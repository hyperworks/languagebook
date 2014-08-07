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

        let idx = advance(str.startIndex, index)
        for portion in portions {
            if portion.wordSpan ~= idx { return portion }
        }
    
        return nil
    }
    
    func wordAtCharacterIndex(index: Int) -> String? {
        return textPortionAtCharacterIndex(index)?.wordInString(script)
    }
}
