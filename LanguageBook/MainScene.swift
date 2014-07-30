import SpriteKit

class MainScene: Scene {
    let verticalGuide = VerticalLineGuide()
    let horizontalGuide = HorizontalLineGuide()
    
    override func didMoveToView(view: SKView!) {
        addChild(verticalGuide)
        addChild(horizontalGuide)
        
        let next = TurquoiseButton(text: "NEXT >")
        next.position = CGPoint(x: 768, y: 192)
        next.name = "next"
        addChild(next)
        
        let prev = TurquoiseButton(text: "< BACK")
        prev.position = CGPoint(x: 256, y: 192)
        prev.name = "prev"
        addChild(prev)
    }
}
