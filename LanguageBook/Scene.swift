import SpriteKit

protocol SceneNavigationDelegate {
    func scene(Scene, shouldAdvanceTo nextScene: Scene)
    func scene(Scene, shouldReturnTo previousScene: Scene)
}

class Scene: SKScene {
    let verticalGuide = VerticalLineGuide()
    let horizontalGuide = HorizontalLineGuide()
    
    var navigationDelegate: SceneNavigationDelegate? = nil
    var guidesEnabled = false
    
    init() {
        // Find out screen size in landscape (since UIScreen will give us size in portrait.)
        let screenSize = UIScreen.mainScreen().bounds.size
        let size = CGSize(width: screenSize.height, height: screenSize.width)
        
        super.init(size: size)
        backgroundColor = SKColor.grayColor()
    }
    
    override func didMoveToView(view: SKView!) {
        if guidesEnabled {
            addChild(verticalGuide)
            addChild(horizontalGuide)
        }
    }
}
