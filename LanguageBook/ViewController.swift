import UIKit
import SpriteKit

class ViewController: UIViewController {
    override func loadView() {
        let skv = SKView(frame: UIScreen.mainScreen().bounds)
        skv.showsFPS = true
        skv.showsDrawCount = true
        skv.backgroundColor = .blackColor()
        skv.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        skv.contentMode = .ScaleAspectFit
        
        view = skv
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (view as SKView).presentScene(MainScene())
    }
}

