import UIKit

// TODO: AudioContentController

class ContentController: UIViewController, MediaController {
    let content: Content
    
    var playheadDidChange: DidChangeHandler? = nil
    var playhead: AudioTime = AudioTime()
    
    var scopeDidChange: DidChangeHandler? = nil
    var scope: AudioInterval = AudioInterval()
    
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
