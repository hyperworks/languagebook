import SpriteKit

class NavigableScene: Scene {
    let nextButton = Button(text: "NEXT >")
    let previousButton = Button(text: "< PREV")

    var nextSceneType: Scene.Type? { return nil }
    var previousSceneType: Scene.Type? { return nil }

    func nextScene() -> Scene? {
        if let sceneType = nextSceneType {
            let next = sceneType()
            next.navigationDelegate = navigationDelegate
            return next
        }

        return nil
    }

    func previousScene() -> Scene? {
        if let sceneType = previousSceneType {
            let previous = sceneType()
            previous.navigationDelegate = navigationDelegate
            return previous
        }

        return nil
    }

    override func didMoveToView(view: SKView!) {
        nextButton.position = CGPoint(x: 768, y: 192)
        nextButton.didTapButton = didTapNext
        addChild(nextButton)
        
        previousButton.position = CGPoint(x: 256, y: 192)
        previousButton.didTapButton = didTapPrevious
        addChild(previousButton)
    }
    
    func didTapNext() {
        if let next = nextScene() {
            navigationDelegate?.scene(self, shouldAdvanceTo: next)
        }
    }
    
    func didTapPrevious() {
        if let prev = previousScene() {
            navigationDelegate?.scene(self, shouldReturnTo: prev)
        }
    }
}
