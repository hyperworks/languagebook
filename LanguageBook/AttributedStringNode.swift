import UIKit
import SpriteKit

@objc protocol AttributedStringNodeDelegate {
    optional func attributedStringNode(node: AttributedStringNode, didTapSubstring substring: NSString)
    optional func attributedStringNode(node: AttributedStringNode, didTapWord word: NSString)
}

class AttributedStringNode: SKSpriteNode {
    private var _textStorage: NSTextStorage? = nil
    private var _stringImage: UIImage? = nil
    private var _topOffset: CGFloat = 0.0

    weak var delegate: AttributedStringNodeDelegate?
    let layoutManager = NSLayoutManager()

    var attributedString: NSAttributedString? {
        get { return _textStorage }
        set {
            _textStorage?.removeLayoutManager(layoutManager)
            _textStorage = !newValue ? nil : NSTextStorage(attributedString: newValue)
            _textStorage?.addLayoutManager(layoutManager)

            invalidateStringImage()
        }
    }

    override var size: CGSize {
        didSet {
            if layoutManager.textContainers.count > 0 {
                layoutManager.removeTextContainerAtIndex(0)
            }

            layoutManager.addTextContainer(NSTextContainer(size: size))
            invalidateStringImage()
        }
    }


    convenience init(attributedString: NSAttributedString, nodeSize: CGSize) {
        self.init(size: nodeSize)
        self.attributedString = attributedString
    }

    init(size: CGSize) {
        super.init(texture: nil, color: nil, size: size)
        userInteractionEnabled = true
    }


    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        if !_textStorage { return }
        let ts = _textStorage!

        // Since UIKit uses a different co-ordinate system to SpriteKit, we need to be careful
        // when moving CGPoints since the meaning of moving up the Y axis in SpriteKit (y+ = up)
        // actually translates to moving down in UIKit (y+ = down)
        var originDelta = anchorPoint * size
        originDelta.y *= -1.0

        var offset = touches.anyObject().locationInNode(self)
        offset += originDelta // move origin from SK to UIKit
        offset.y *= -1.0 // flip co-ordinates space from SK to UIKit

        // Check if we're touching somewhere inside layoutmanager's drawn text.
        let container = layoutManager.textContainers[0] as NSTextContainer
        let usedRect = layoutManager.usedRectForTextContainer(container)

        offset -= CGPoint(x: 0, y: _topOffset)
        if !CGRectContainsPoint(CGRect(origin: CGPointZero, size: usedRect.size), offset) {
            return
        }

        // Extract the character at the position
        let rawString: String = ts.string!
        let rawIndex = layoutManager.characterIndexForPoint(offset,
            inTextContainer: container, fractionOfDistanceBetweenInsertionPoints: nil)

        if rawIndex == NSNotFound || rawIndex >= countElements(rawString) {
            return
        }

        let charIndex = advance(rawString.startIndex, rawIndex)
        let charRange = rawString.rangeOfComposedCharacterSequenceAtIndex(charIndex)
        let char = rawString.substringWithRange(charRange)

        delegate?.attributedStringNode?(self, didTapSubstring: char)
    }


    private func invalidateStringImage() {
        if !_textStorage || layoutManager.textContainers.count == 0 {
            _stringImage = nil
            texture = nil
            return
        }

        _stringImage = renderStringImage()
        texture = SKTexture(image: _stringImage)
    }

    private func renderStringImage() -> UIImage {
        assert(_textStorage, "renderStringImage() with nil string.")
        assert(layoutManager.textContainers.count > 0, "renderStringImage() with textContainer specified.")

        let range = NSRange(location: 0, length: layoutManager.numberOfGlyphs)
        let container = layoutManager.textContainers[0] as NSTextContainer
        let usedRect = layoutManager.usedRectForTextContainer(container)

        _topOffset = CGFloat(size.height - usedRect.height) * 0.5

        UIGraphicsBeginImageContext(size)
        layoutManager.drawGlyphsForGlyphRange(range, atPoint: CGPoint(x: 0, y: _topOffset))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
