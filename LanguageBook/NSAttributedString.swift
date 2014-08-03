import UIKit
import SpriteKit

extension NSAttributedString {
    convenience init(_ text: NSString, fontName: NSString, fontSize: CGFloat, color: SKColor,
        alignment: NSTextAlignment, lineBreakMode: NSLineBreakMode) {

        let font = UIFont(name: fontName, size: fontSize)
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        style.lineBreakMode = lineBreakMode

        self.init(string: text, attributes: [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: color,
            NSParagraphStyleAttributeName: style,
        ])
    }

    func asNode(#size: CGSize) -> AttributedStringNode {
        return AttributedStringNode(attributedString: self, nodeSize: size)
    }
}

