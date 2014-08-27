import UIKit

// TODO: AudioContentController

class ContentController: UIViewController, MediaController {
    private var _playhead: AudioTime = AudioTime()
    private var _scope: AudioInterval = AudioInterval()
    
    let content: Content
    
    var playheadDidChange: DidChangeHandler? = nil
    var playhead: AudioTime {
        get { return _playhead }
        set {
            _playhead = newValue
            playheadDidChange?()
        }
    }
    
    var scopeDidChange: DidChangeHandler? = nil
    var scope: AudioInterval {
        get { return _scope }
        set {
            _scope = newValue
            scopeDidChange?()
        }
    }
    
    var paused: Bool = false
    
    
    class func fromContent(content: Content) -> ContentController {
        switch content {
        case let svg as SVGContent:
            return SVGContentController(SVGContent: svg)
        case let image as ImageContent:
            return ImageContentController(ImageContent: image)
        default:
            fatalError("unsupported content type.")
        }
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(content: Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
}
