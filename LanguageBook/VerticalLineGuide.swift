import SpriteKit

class VerticalLineGuide: SKShapeNode {
    let stops = [256, 512, 768]
    init() {
        super.init()
        
        let guide = CGPathCreateMutable()
        for x in stops {
            CGPathMoveToPoint(guide, nil, CGFloat(x)-512.0, -384)
            CGPathAddLineToPoint(guide, nil, CGFloat(x)-512.0, 384)
        }
        
        path = guide
        strokeColor = .redColor()
        position = CGPoint(x: 512, y: 384)
        userInteractionEnabled = false
    }
   
}
