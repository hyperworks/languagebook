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
    
    override func didTapNext() {
        view.presentScene(ThirdScene(), transition: SKTransition.fadeWithDuration(1.0))
    }
    
    override func didTapPrevious() {
        view.presentScene(MainScene(),
        transition: SKTransition.revealWithDirection(.Down, duration: 1.0))
    }
}
