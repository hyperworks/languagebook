import SpriteKit

class NavigableScene: Scene {
    let nextButton = Button(text: "NEXT >")
    let previousButton = Button(text: "< PREV")
    
    override func didMoveToView(view: SKView!) {
        nextButton.position = CGPoint(x: 768, y: 192)
        nextButton.onPress = didTapNext
        addChild(nextButton)
        
        previousButton.position = CGPoint(x: 256, y: 192)
        previousButton.onPress = didTapPrevious
        addChild(previousButton)
    }
    
    func nextScene() -> Scene? { return nil }
    func previousScene() -> Scene? { return nil }
    
    func didTapNext() {
        if let d = navigationDelegate {
            if let next = nextScene() {
                d.scene(self, shouldAdvanceTo: next)
            }
        }
    }
    
    func didTapPrevious() {
        if let d = navigationDelegate {
            if let prev = previousScene() {
                d.scene(self, shouldReturnTo: prev)
            }
        }
    }
}
