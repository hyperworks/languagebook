import SpriteKit

class Button: SKSpriteNode {
    var onPress: () -> Void = { }
    
    init(text: String = "(button)") {
        super.init(texture: SKTexture(imageNamed: "button_base"),
            color: nil,
            size: CGSize(width: 200, height: 100))
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        userInteractionEnabled = true
        color = .blueColor()
        colorBlendFactor = 0.5
        
        var label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = text
        label.fontSize = CGFloat(38.0)
        label.position = CGPoint(x: 0, y: -10)
        label.userInteractionEnabled = false
        addChild(label)
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!){ onPress() }
}
