import UIKit

class SVGContentController: ContentController {
    let svgContent: SVGContent
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(SVGContent svg: SVGContent) {
        self.svgContent = svg
        super.init(content: svg)
    }
    
    // TODO: Add parent folder information. Name alone will surely not load.
    override func loadView() {
        view = SVGKImageView(SVGKImage: SVGKImage(named: svgContent.name))
    }
}

class ImageContentController: ContentController {
    let imageContent: ImageContent
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(ImageContent image: ImageContent) {
        self.imageContent = image
        super.init(content: image)
    }
    
    // TODO: Add parent folder information. Name alone will surely not load.
    override func loadView() {
        view = UIImageView(image: UIImage(named: imageContent.name))
    }
}

class ContentController: UIViewController {
    let content: Content
    
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
