import SpriteKit

class SecondScene: NavigableScene {
    let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        backgroundColor = .blueColor()
        nextButton.color = .blueColor()
        previousButton.color = .blueColor()
        
        titleLabel.position = CGPoint(x: 512, y: 576)
        titleLabel.text = "Second Scene"
        titleLabel.color = .whiteColor()
        addChild(titleLabel)
    }
    
    override func nextScene() -> Scene? { return ThirdScene() }
    override func previousScene() -> Scene? { return MainScene() }
}
