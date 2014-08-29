import Foundation

class Content: Model {
    let page: Page
    
    var path: String { return Model.pathForName(id, inDirectory: page.chapter.id) }
    var fileURL: NSURL { return NSURL.fileURLWithPath(path)! }
    
    
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
        } else if dict["audio"] != nil {
            return AudioContent(page: page, dict: dict)
        }
        
        return Content(page: page, dict: dict)
    }
}
