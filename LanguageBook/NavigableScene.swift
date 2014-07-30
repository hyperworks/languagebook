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
    
    func didTapNext() { /* child overrides */ }
    func didTapPrevious() { /* child overrides */ }
}
