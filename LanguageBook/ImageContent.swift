import Foundation

class ImageContent: Content {
    let name: String
    
    lazy private(set) var image: UIImage = {
        return UIImage(contentsOfFile: self.path)
    }()
    
    override init(page: Page, dict: JSONDict) {
        name = dict["image"]! as String
        super.init(page: page, id: name)
    }
}