import SpriteKit

class TurquoiseButton: SKSpriteNode {
    init(text: String = "(button)") {
        super.init(texture: SKTexture(imageNamed: "button_turquoise"),
            color: nil,
            size: CGSize(width: 200, height: 100))
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        userInteractionEnabled = true
        
        var label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = text
        label.fontSize = CGFloat(38.0)
        label.position = CGPoint(x: 0, y: -10)
        label.userInteractionEnabled = false
        addChild(label)
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!){
        NSLog("touchBegan")
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        NSLog("touchEnd")
    }
}
