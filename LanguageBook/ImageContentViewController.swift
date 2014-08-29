import Foundation

class ImageContentViewController: ContentViewController {
    let imageContent: ImageContent
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(ImageContent image: ImageContent) {
        self.imageContent = image
        super.init(content: image)
    }
    
    override func loadView() {
        let image = UIImage(contentsOfFile: imageContent.path)
        let v = UIImageView(image: image)
        v.backgroundColor = .clearColor()
        v.opaque = false
        
        v.setTranslatesAutoresizingMaskIntoConstraints(false)
        v.addConstraint(NSLayoutConstraint(item: v, width: image.size.width))
        v.addConstraint(NSLayoutConstraint(item: v, height: image.size.height))
        view = v
    }
}

