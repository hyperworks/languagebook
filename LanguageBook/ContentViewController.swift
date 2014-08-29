

class ContentViewController: UIViewController, MediaController {
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
    
    
    class func fromContent(content: Content) -> ContentViewController {
        switch content {
        case let svg as SVGContent:
            return SVGContentViewController(SVGContent: svg)
        case let image as ImageContent:
            return ImageContentViewController(ImageContent: image)
        case let audio as AudioContent:
            return AudioContentViewController(AudioContent: audio)
        default:
            fatalError("unsupported content type.")
        }
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(content: Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let v = UIView(frame: CGRectMake(0, 0, 768, 1024))
        v.userInteractionEnabled = false
        v.backgroundColor = .clearColor()
        v.opaque = false
        
        v.setTranslatesAutoresizingMaskIntoConstraints(false)
        v.addConstraint(NSLayoutConstraint(item: v, width: 768))
        v.addConstraint(NSLayoutConstraint(item: v, height: 1024))
        view = v
    }
}
