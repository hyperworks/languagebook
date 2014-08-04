import UIKit
import SpriteKit

class Dummy {
    class func attributesForTitle() -> MarkedTextStorage.AttributeDictionary {
        let font = UIFont(name: "Thonburi", size: 30.0)
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        style.lineBreakMode = .ByWordWrapping

        return [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: SKColor.whiteColor(),
            NSParagraphStyleAttributeName: style,
        ]
    }

    class func scenarioOne() -> MarkedTextStorage{
        return MarkedTextStorage(
            portions: [
                TextPortion(time: 0.0, word: "Thai "),
                TextPortion(time: 1.0, word: "Reading "),
                TextPortion(time: 2.0, word: "for Speaking "),
                TextPortion(time: 2.5, word: "by Darryl Sweetland "),
                TextPortion(time: 3.0, word: "กอ ไก่"),
                TextPortion(time: 3.5, word: "ขอ ไข่"),
                TextPortion(time: 4.0, word: "ขอ ขวด"),
                TextPortion(time: 4.5, word: "คอ ควาย"),
            ],
            attributes: attributesForTitle())
    }
}
