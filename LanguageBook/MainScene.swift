import SpriteKit

class MainScene: NavigableScene {
    let titleLabel = SKLabelNode(fontNamed: "Thonburi")
    
    override func nextScene() -> Scene? { return SecondScene() }
    
    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        backgroundColor = .grayColor()
        nextButton.color = .grayColor()
        previousButton.color = .grayColor()
        previousButton.hidden = true
        
        titleLabel.position = CGPoint(x: 512, y: 576)
        titleLabel.text = "ชามเขียวคว่ำเช้า ชามขาวคว่ำค่ำ"
        titleLabel.fontSize = 24.0
        titleLabel.color = .whiteColor()
        addChild(titleLabel)
    }
}
