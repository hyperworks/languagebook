import Foundation

class Book: Model {
    private(set) var chapters: [Chapter] = []
    
    class func fromJSON() -> Book {
        dump("fromJSON")
        return Book(dict: Model.loadJSON("contents.json") as JSONDict)
    }
    
    override init(dict: JSONDict) {
        super.init(id: "book")
        
        chapters = (dict["chapters"]! as JSONArray)
            .map({ Chapter.fromJSON(id: $0 as String, inBook: self) })
    }
}
