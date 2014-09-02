import Foundation

class ImageContent: Content {
    private lazy var _image: UIImage = UIImage(contentsOfFile: self.path)

    let name: String
    var image: UIImage { return _image }
    override var dimension: CGSize { return image.size }

    override init(page: Page, dict: JSONDict) {
        name = dict["image"]! as String
        super.init(page: page, id: name)
    }
}