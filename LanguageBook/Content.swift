import Foundation

class Content: Model {
    private var _memoryWarning: Notification.Observation
    
    let page: Page
    let tags: [String]
    
    var path: String { return Model.pathForName(id, inDirectory: page.chapter.id) }
    var fileURL: NSURL { return NSURL.fileURLWithPath(path)! }

    var dimension: CGSize { return CGSizeZero }
    
    convenience init(page: Page, dict: JSONDict) {
        let id = (dict["id"] ?? "") as String
        self.init(page: page, id: id, dict: dict)
    }
    
    init(page: Page, id: String, dict: JSONDict) {
        self.page = page
        if let tags = (dict["tags"] ?? []) as? JSONArray {
            self.tags = (tags as JSONArray).cast({ $0 as? String })
        } else {
            self.tags = []
        }
        
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
