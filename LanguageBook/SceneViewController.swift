import UIKit
import SpriteKit

class SceneViewController: UIViewController {
    let scene: SKScene
    
    var paused: Bool {
    get { return (view as SKView).paused }
    set { (view as SKView).paused = newValue }
    }
    
    init(_ scene: SKScene) {
        self.scene = scene
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let skv = SKView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
        skv.showsDrawCount = true
        skv.showsFPS = true
        skv.backgroundColor = .grayColor()
        
        view = skv
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (view as SKView).presentScene(scene)
    }
}
