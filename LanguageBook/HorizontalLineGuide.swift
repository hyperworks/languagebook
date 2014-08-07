import SpriteKit

class HorizontalLineGuide: SKShapeNode {
    let stops = [192, 384, 576]

    required init(coder aDecoder: NSCoder!) { fatalError("KVC initializer not supported.") }

    override init() {
        super.init()
        
        let guide = CGPathCreateMutable()
        for y in stops {
            CGPathMoveToPoint(guide, nil, -512, CGFloat(y)-384)
            CGPathAddLineToPoint(guide, nil, 512, CGFloat(y)-384)
        }
        
        path = guide
        strokeColor = .redColor()
        position = CGPoint(x: 512, y: 384)
        userInteractionEnabled = false
    }
}