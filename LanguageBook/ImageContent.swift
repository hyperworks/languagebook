import Foundation

class ImageContent: Content {
    let name: String
    
    override init(page: Page, dict: JSONDict) {
        name = dict["image"]! as String
        super.init(page: page, id: name)
    }
}