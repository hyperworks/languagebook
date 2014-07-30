import SpriteKit

class NavigableScene: Scene {
    let nextButton = Button(text: "NEXT >")
    let previousButton = Button(text: "< PREV")
    
    func nextScene() -> Scene? { return nil }
    func previousScene() -> Scene? { return nil }
    
    override func didMoveToView(view: SKView!) {
        nextButton.position = CGPoint(x: 768, y: 192)
        nextButton.onPress = didTapNext
        addChild(nextButton)
        
        previousButton.position = CGPoint(x: 256, y: 192)
        previousButton.onPress = didTapPrevious
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
