import Foundation

class SVGContent: Content {
    let name: String
    let interactive: Bool
    
    override init(dict: JSONDict) {
        name = dict["svg"]! as String
        interactive = (dict["interactive"] ?? false) as Bool
        
        super.init(id: name)
    }
}

class ImageContent: Content {
    let name: String
    
    override init(dict: JSONDict) {
        name = dict["image"]! as String
        super.init(id: name)
    }
}

class Content: Model {
    class func fromJSON(dict: JSONDict) -> Content {
        if dict["svg"] != nil {
            return SVGContent(dict: dict)
        } else if dict["image"] != nil {
            return ImageContent(dict: dict)
        }
        
        return Content(dict: dict)
    }
}
