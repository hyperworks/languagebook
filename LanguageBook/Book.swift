import Foundation

class Book: Model {
    let chapters: [Chapter]
    
    class func fromJSON() -> Book {
        return Book(dict: Model.loadJSON("contents") as JSONDict)
    }
    
    override init(dict: JSONDict) {
        chapters = (dict["chapters"]! as JSONArray)
            .map({ Chapter.fromJSON(id: $0 as String) })
        super.init(id: "book")
    }
}
