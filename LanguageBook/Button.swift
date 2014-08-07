import SpriteKit

class Button: SKSpriteNode {
    typealias DidTouchFunction = () -> Void

    let labelNode = SKLabelNode(fontNamed: "Chalkduster")
    var didTapButton: DidTouchFunction?

    convenience init(text: String = "(button)") {
        self.init(texture: SKTexture(imageNamed: "button_base"), color: nil,
            size: CGSize(width: 200, height: 100))
        labelNode.text = text
    }

    required init(coder aDecoder: NSCoder!) { fatalError("KVC initializer not supported.") }

    override required init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        userInteractionEnabled = true
        colorBlendFactor = 0.5

        labelNode.fontSize = CGFloat(38.0)
        labelNode.position = CGPoint(x: 0, y: -10)
        labelNode.userInteractionEnabled = false
        addChild(labelNode)
    }

    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) { didTapButton?() }
}
