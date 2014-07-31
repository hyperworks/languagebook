import SpriteKit

class SecondScene: NavigableScene {
    let titleLabel = SKLabelNode(fontNamed: "Thonburi")
    
    override var nextSceneType: Scene.Type? { return ThirdScene.self }
    override var previousSceneType: Scene.Type? { return MainScene.self }

    init() { }
    
    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        backgroundColor = .blueColor()
        nextButton.color = .blueColor()
        previousButton.color = .blueColor()
        
        titleLabel.position = CGPoint(x: 512, y: 576)
        titleLabel.text = "ยักษ์ใหญ่ไล่ยักษ์เล็ก ยักษ์เล็กไล่ยักษ์ใหญ่"
        titleLabel.fontSize = 24.0
        titleLabel.color = .whiteColor()
        addChild(titleLabel)
    }
}
