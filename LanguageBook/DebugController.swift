import UIKit

class DebugController: UIViewController, SerialController, MediaController {
    let knownColors = [
        UIColor.redColor(),
        UIColor.blueColor(),
        UIColor.greenColor(),
        UIColor.grayColor()
    ]
    
    let backgroundColor: UIColor
    
    lazy private(set) var nextViewController: UIViewController? = DebugController()
    lazy private(set) var previousViewController: UIViewController? = DebugController()
    
    var playheadDidChange: DidChangeHandler? = nil
    var playhead: AudioTime = AudioTime()
    
    var scopeDidChange: DidChangeHandler? = nil
    var scope: AudioInterval = AudioInterval()
    
    var paused: Bool {
        get { return false }
        set { dump(newValue, name: "paused") }
    }
    
    
    convenience override init() { self.init(nibName: nil, bundle: nil) }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        backgroundColor = knownColors[Random.int(knownColors.count)]
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        v.backgroundColor = backgroundColor
        view = v
    }
    
}
