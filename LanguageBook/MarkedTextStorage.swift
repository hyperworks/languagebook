import UIKit

class MarkedTextStorage: NSTextStorage {
    typealias AttributeDictionary = [NSObject: AnyObject]
    
    private var _attributedString: NSMutableAttributedString
    private var _portions: [TextPortion]
    
    convenience init(times: [Float], words: [String], attributes: AttributeDictionary = [:]) {
        assert(times.count == words.count, "list of time marks and words have different length.")
        
        let portions = map(Zip2(times, words), { TextPortion(time: $0.0, word: $0.1) })
        self.init(portions: portions, attributes: attributes)
    }
    
    init(portions: [TextPortion], attributes: AttributeDictionary = [:]) {
        _portions = portions
        
        let fullString = "".join(map(portions, { $0.word }))
        _attributedString = NSMutableAttributedString(string: fullString, attributes: attributes)
        super.init()
    }
    
    
    func textPortionAtCharacterIndex(index: Int) -> TextPortion? {
        var acc = 0
        for portion in _portions {
            acc += countElements(portion.word)
            if acc > index {
                return portion
            }
        }
        
        return nil
    }
    
    func wordAtCharacterIndex(index: Int) -> String? {
        return textPortionAtCharacterIndex(index)?.word
    }
    
    
    // MARK: NSTextStorage
    override var string: String! { return _attributedString.string }
    override var length: Int { return _attributedString.length }
    
    override func replaceCharactersInRange(range: NSRange, withString str: String!) {
        _attributedString.replaceCharactersInRange(range, withString: str)
        
        edited(NSTextStorageEditActions.EditedCharacters,
            range: range, changeInLength: (countElements(str!) - range.length))
    }
    
    override func setAttributes(attrs: [NSObject : AnyObject]!, range: NSRange) {
        _attributedString.setAttributes(attrs, range: range)
        edited(NSTextStorageEditActions.EditedAttributes, range: range, changeInLength: 0)
    }
    
    override func attributesAtIndex(location: Int, effectiveRange range: NSRangePointer) -> [NSObject : AnyObject]! {
        return _attributedString.attributesAtIndex(location, effectiveRange: range)
    }
}
