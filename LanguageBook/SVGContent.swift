import Foundation

class SVGContent: Content {
    let name: String
    let interactive: Bool

    var image: SVGKImage { return SVGImageCache.get(self.path) }
    override var dimension: CGSize { return image.size }


    override init(page: Page, dict: JSONDict) {
        name = dict["svg"]! as String
        interactive = (dict["interactive"] ?? false) as Bool
        
        super.init(page: page, id: name)
    }
}