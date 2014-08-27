import Foundation

class Chapter: Model {
    let book: Book
    private(set) var pages: [Page] = []
    
    class func fromJSON(#id: String, inBook book: Book) -> Chapter {
        return Chapter(book: book, dict: Model.loadJSON("contents.json", inDirectory: id) as JSONDict)
    }
    
    init(book: Book, dict: JSONDict) {
        self.book = book
        super.init(dict: dict)
        
        pages = (dict["pages"]! as JSONArray)
            .map({ Page(chapter: self, dict: $0 as JSONDict) })
    }
}
