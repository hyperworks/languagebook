import SpriteKit

class MainScene: Scene {
    override func didMoveToView(view: SKView!) {
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "HELLO, WORLD!"
        label.position = CGPoint(x: 512, y: 384)
        addChild(label)
    }
}
