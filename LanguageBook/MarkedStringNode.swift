import UIKit
import SpriteKit

@objc protocol MarkedStringNodeDelegate {
    optional func markedStringNode(node: MarkedStringNode, didTapPortion portion: TextPortion)
}

class MarkedStringNode: SKSpriteNode {
    private var _markedString: MarkedString? = nil
    private var _stringImage: UIImage? = nil
    private var _topOffset: CGFloat = 0.0

    weak var delegate: MarkedStringNodeDelegate?
    let layoutManager = NSLayoutManager()

    var markedString: MarkedString? {
        get { return _markedString }
        set {
            _markedString?.script.removeLayoutManager(layoutManager)
            _markedString = !newValue ? nil : newValue
            _markedString?.script.addLayoutManager(layoutManager)

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


    convenience init(markedString: MarkedString, nodeSize: CGSize = CGSizeZero) {
        self.init(size: nodeSize)
        self.markedString = markedString
    }
    
    init(size: CGSize = CGSizeZero) {
        super.init(texture: nil, color: nil, size: size)
        userInteractionEnabled = true
    }


    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        if !_markedString { return }
        let ms = _markedString!

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
        let rawString: String = ms.script.string!
        let rawIndex = layoutManager.characterIndexForPoint(offset,
            inTextContainer: container, fractionOfDistanceBetweenInsertionPoints: nil)
        let portion = ms.textPortionAtCharacterIndex(rawIndex)
        
        if let p = portion? {
            delegate?.markedStringNode?(self, didTapPortion: p)
        }
    }


    private func invalidateStringImage() {
        if !_markedString || layoutManager.textContainers.count == 0 || size == CGSizeZero {
            _stringImage = nil
            texture = nil
            return
        }

        _stringImage = renderStringImage()
        texture = SKTexture(image: _stringImage)
    }

    private func renderStringImage() -> UIImage {
        assert(_markedString, "renderStringImage() with nil string.")
        assert(layoutManager.textContainers.count > 0, "renderStringImage() with no textContainer specified.")

        let range = NSRange(location: 0, length: layoutManager.numberOfGlyphs)
        let container = layoutManager.textContainers[0] as NSTextContainer
        
        // TODO: usedRectForTextContainer sometimes returns CGRectZero so we do this for now.
        let usedRect = layoutManager.boundingRectForGlyphRange(range, inTextContainer: container)
        _topOffset = CGFloat(size.height - usedRect.height) * 0.5

        UIGraphicsBeginImageContext(size)
        layoutManager.drawGlyphsForGlyphRange(range, atPoint: CGPoint(x: 0, y: _topOffset))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
