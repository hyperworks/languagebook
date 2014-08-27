import Foundation

class Content: Model {
    let page: Page
    
    var path: String {
        return Content.pathForName(id, inDirectory: page.chapter.id)
    }
    
    init(page: Page, dict: JSONDict) {
        self.page = page
        super.init(dict: dict)
    }
    
    init(page: Page, id: String) {
        self.page = page
        super.init(id: id)
    }
    
    class func fromJSON(#page: Page, dict: JSONDict) -> Content {
        if dict["svg"] != nil {
            return SVGContent(page: page, dict: dict)
        } else if dict["image"] != nil {
            return ImageContent(page: page, dict: dict)
        }
        
        return Content(page: page, dict: dict)
    }
    
    
    class func pathForName(name: String, inDirectory dir: String?) -> String {
        let bundle = NSBundle.mainBundle()
        let subdir = dir == nil ? "Assets" : "Assets/\(dir!)"
        dump(subdir, name: "dir")
        
        return bundle.pathForResource(name, ofType: nil, inDirectory: subdir)!
    }
}
