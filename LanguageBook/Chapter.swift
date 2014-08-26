import Foundation

class Chapter: Model {
    let pages: [Page]
    
    class func fromJSON(#id: String) -> Chapter {
        return Chapter(dict: Model.loadJSON("contents", inDirectory: id) as JSONDict)
    }
    
    override init(dict: JSONDict) {
        pages = (dict["pages"]! as JSONArray)
            .map({ Page(dict: $0 as JSONDict) })
        
        super.init(dict: dict)
    }
}
