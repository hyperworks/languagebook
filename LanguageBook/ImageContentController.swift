import Foundation

class ImageContentController: ContentController {
    let imageContent: ImageContent
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(ImageContent image: ImageContent) {
        self.imageContent = image
        super.init(content: image)
    }
    
    // TODO: Add parent folder information. Name alone will surely not load.
    override func loadView() {
        view = UIImageView(image: UIImage(contentsOfFile: imageContent.path))
    }
}
