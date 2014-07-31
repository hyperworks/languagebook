import SpriteKit

class ThirdScene: NavigableScene {
    let titleLabel = SKLabelNode(fontNamed: "Thonburi")
    
    override var previousSceneType: Scene.Type? { return SecondScene.self }

    init() { }

    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        backgroundColor = .greenColor()
        nextButton.color = .greenColor()
        previousButton.color = .greenColor()
        nextButton.hidden = true
        
        titleLabel.position = CGPoint(x: 512, y: 576)
        titleLabel.text = "ระนอง ระยอง ยะลา"
        titleLabel.fontSize = 24.0
        titleLabel.color = .whiteColor()
        addChild(titleLabel)
    }
}
