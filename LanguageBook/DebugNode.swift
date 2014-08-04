import SpriteKit

class DebugNode: SKSpriteNode {
    convenience init(sprite: SKSpriteNode) {
        self.init(target: sprite, size: sprite.size)
    }

    init(target: SKNode, size: CGSize) {
        super.init(texture: nil, color: SKColor.blueColor(), size: size)
        position = target.position
        zPosition -= 1
    }
}
