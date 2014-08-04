import UIKit
import SpriteKit

@objc protocol MarkedTextNodeDelegate {
    optional func markedTextNode(node: MarkedTextNode, didTapPortion portion: TextPortion)
}

class MarkedTextNode: SKSpriteNode {
    private var _markedText: MarkedTextStorage? = nil
    private var _stringImage: UIImage? = nil
    private var _topOffset: CGFloat = 0.0

    weak var delegate: MarkedTextNodeDelegate?
    let layoutManager = NSLayoutManager()

    var markedText: MarkedTextStorage? {
        get { return _markedText }
        set {
            _markedText?.removeLayoutManager(layoutManager)
            _markedText = !newValue ? nil : newValue
            _markedText?.addLayoutManager(layoutManager)

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


    convenience init(markedText: MarkedTextStorage, nodeSize: CGSize = CGSizeZero) {
        self.init(size: nodeSize)
        self.markedText = markedText
    }
    
    init(size: CGSize = CGSizeZero) {
        super.init(texture: nil, color: nil, size: size)
        userInteractionEnabled = true
    }


    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        if !_markedText { return }
        let text = _markedText!

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
        let rawString: String = text.string!
        let rawIndex = layoutManager.characterIndexForPoint(offset,
            inTextContainer: container, fractionOfDistanceBetweenInsertionPoints: nil)
        let portion = text.textPortionAtCharacterIndex(rawIndex)
        
        if let p = portion? {
            delegate?.markedTextNode?(self, didTapPortion: p)
        }
    }


    private func invalidateStringImage() {
        if !_markedText || layoutManager.textContainers.count == 0 || size == CGSizeZero {
            _stringImage = nil
            texture = nil
            return
        }

        _stringImage = renderStringImage()
        texture = SKTexture(image: _stringImage)
    }

    private func renderStringImage() -> UIImage {
        assert(_markedText, "renderStringImage() with nil string.")
        assert(layoutManager.textContainers.count > 0, "renderStringImage() with no textContainer specified.")

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
