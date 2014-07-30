import SpriteKit

class ThirdScene: NavigableScene {
    let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        backgroundColor = .greenColor()
        nextButton.color = .greenColor()
        previousButton.color = .greenColor()
        nextButton.hidden = true
        
        titleLabel.position = CGPoint(x: 512, y: 576)
        titleLabel.text = "Third Scene"
        titleLabel.color = .whiteColor()
        addChild(titleLabel)
    }
    
    override func didTapPrevious() {
        view.presentScene(SecondScene(), transition: SKTransition.doorwayWithDuration(1.0))
    }
}
