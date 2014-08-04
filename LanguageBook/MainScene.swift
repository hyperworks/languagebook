import SpriteKit

class MainScene: NavigableScene, MarkedTextNodeDelegate {
    let titleLabel: SKLabelNode = SKLabelNode(fontNamed: "Thonburi")
    let storyTextNode: MarkedTextNode = MarkedTextNode(markedText: Dummy.scenarioOne())
    
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

        storyTextNode.position = CGPoint(x: 300, y: 400)
        storyTextNode.size = CGSize(width: 300, height: 300)
        storyTextNode.delegate = self
        addChild(storyTextNode)
        addChild(DebugNode(sprite: storyTextNode))
    }
    
    
    // MARK: AttributedStringNodeDelegate
    func attributedStringNode(node: AttributedStringNode, didTapSubstring substring: NSString) {
        titleLabel.text = substring
    }
}
