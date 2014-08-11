import SpriteKit

class NavigableScene: Scene {
    let nextButton = Button(text: "NEXT >")
    let previousButton = Button(text: "< PREV")

    var hasNextScene: Bool { return false }
    var nextScene: Scene { fatalError("must be implemented by child class.") }
    
    var hasPreviousScene: Bool { return false }
    var previousScene: Scene { fatalError("must be implemented by child class.") }
    
    override var backgroundColor: UIColor! {
        didSet {
            nextButton.color = backgroundColor
            previousButton.color = backgroundColor
        }
    }
    

    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        if hasNextScene {
            nextButton.position = CGPoint(x: 768, y: 192)
            nextButton.didTapButton = didTapNext
            addChild(nextButton)
        }
        
        if hasPreviousScene {
            previousButton.position = CGPoint(x: 256, y: 192)
            previousButton.didTapButton = didTapPrevious
            addChild(previousButton)
        }
    }
    
    func didTapNext() { navigationDelegate?.scene(self, shouldAdvanceTo: nextScene) }
    func didTapPrevious() { navigationDelegate?.scene(self, shouldReturnTo: previousScene) }
}
