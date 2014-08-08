import SpriteKit

class ThirdScene: LessonScene {
    override var hasPreviousScene: Bool { return true }
    override var previousScene: Scene { return SecondScene() }

    override var setName: String { return "03" }
}
