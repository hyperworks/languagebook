import SpriteKit

class MainScene: NavigableScene {
    let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        backgroundColor = .grayColor()
        nextButton.color = .grayColor()
        previousButton.color = .grayColor()
        previousButton.hidden = true
        
        titleLabel.position = CGPoint(x: 512, y: 576)
        titleLabel.text = "Main Scene"
        titleLabel.color = .whiteColor()
        addChild(titleLabel)
    }
    
    override func didTapNext() {
        view.presentScene(SecondScene(), transition: SKTransition.crossFadeWithDuration(1.0))
    }
}
