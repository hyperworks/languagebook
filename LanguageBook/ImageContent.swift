import Foundation

class ImageContent: Content {
    let name: String
    var image: UIImage { return ImageCache.get(path) }
    
    override var dimension: CGSize { return image.size }

    init(page: Page, dict: JSONDict) {
        name = dict["image"]! as String
        super.init(page: page, id: name, dict: dict)
    }
}