import Foundation

class SVGContent: Content {
    let name: String
    let interactive: Bool
    
    lazy private(set) var image: SVGKImage = {
        return SVGImageCache.sharedInstance[self.path]
    }()
    
    override init(page: Page, dict: JSONDict) {
        name = dict["svg"]! as String
        interactive = (dict["interactive"] ?? false) as Bool
        
        super.init(page: page, id: name)
    }
}