import SpriteKit

class DebugNode: SKSpriteNode {
    convenience init(sprite: SKSpriteNode) {
        self.init(target: sprite, size: sprite.size)
    }

    required init(coder aDecoder: NSCoder!) { fatalError("KVC initializer not supported.") }

    init(target: SKNode, size: CGSize) {
        super.init(texture: nil, color: SKColor.blueColor(), size: size)
        position = target.position
        zPosition -= target.zPosition + 1.0
    }
}
