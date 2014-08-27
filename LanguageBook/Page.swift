import UIKit

class Page: Model {
    let chapter: Chapter
    private(set) var contents: [Content] = []
    
    init(chapter: Chapter, dict: JSONDict) {
        self.chapter = chapter
        super.init(dict: dict)
        
        contents = (dict["contents"]! as JSONArray)
            .map({ Content.fromJSON(page: self, dict: $0 as JSONDict) })
    }
}
