import SpriteKit

class Scene: SKScene {
    init() {
        // Find out screen size in landscape (since UIScreen will give us size in portrait.)
        let screenSize = UIScreen.mainScreen().bounds.size
        let size = CGSize(width: screenSize.height, height: screenSize.width)
        
        super.init(size: size)
        backgroundColor = SKColor.grayColor()
    }
}
