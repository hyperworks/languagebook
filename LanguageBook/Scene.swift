import SpriteKit

@objc protocol SceneNavigationDelegate {
    func scene(Scene, shouldAdvanceTo nextScene: Scene)
    func scene(Scene, shouldReturnTo previousScene: Scene)
}

class Scene: SKScene {
    let verticalGuide = VerticalLineGuide()
    let horizontalGuide = HorizontalLineGuide()
    
    weak var navigationDelegate: SceneNavigationDelegate? = nil
    var guidesEnabled: Bool { return false }

    required init(coder aDecoder: NSCoder!) { fatalError("KVC initializer not supported.") }

    override required init() {
        let screenSize = UIScreen.mainScreen().bounds.size
        let size = screenSize.width > screenSize.height ? screenSize :
            CGSize(width: screenSize.height, height: screenSize.width)
        
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
