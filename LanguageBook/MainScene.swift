import SpriteKit

class MainScene: NavigableScene, AttributedStringNodeDelegate {
    let titleLabel: SKLabelNode = SKLabelNode(fontNamed: "Thonburi")
    
    override var nextSceneType: Scene.Type? { return SecondScene.self }

    init() { }

    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        backgroundColor = .grayColor()
        nextButton.color = .grayColor()
        previousButton.color = .grayColor()
        previousButton.hidden = true
        
        titleLabel.text = "(ch)"
        titleLabel.position = CGPoint(x: 512, y: 576)
        addChild(titleLabel)

        let firstLine = NSAttributedString("ชามเขียวคว่ำเช้าชามขาวคว่ำค่ำ",
            fontName: "Thonburi", fontSize: CGFloat(48.0), color: SKColor.whiteColor(),
            alignment: .Center, lineBreakMode: .ByWordWrapping)

        let textBoxSize = CGSize(width: 200, height: 300)
        let firstLineNode = AttributedStringNode(attributedString: firstLine, nodeSize: textBoxSize)

        firstLineNode.position = CGPoint(x: 300, y: 400)
        firstLineNode.delegate = self
        
        addChild(firstLineNode)
        addChild(DebugNode(sprite: firstLineNode))
    }
    
    
    // MARK: AttributedStringNodeDelegate
    func attributedStringNode(node: AttributedStringNode, didTapSubstring substring: NSString) {
        titleLabel.text = substring
    }
}
