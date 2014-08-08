import SpriteKit
import AVFoundation

class MainScene: LessonScene {
    override var hasNextScene: Bool { return true }
    override var nextScene: Scene { return SecondScene() }
    
    override var setName: String { return "01" }
}
