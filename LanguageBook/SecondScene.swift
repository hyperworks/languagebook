import SpriteKit

class SecondScene: LessonScene {
    override var hasNextScene: Bool { return true }
    override var nextScene: Scene { return ThirdScene() }
    
    override var hasPreviousScene: Bool { return true }
    override var previousScene: Scene { return MainScene() }
    
    override var setName: String { return "02" }
}
