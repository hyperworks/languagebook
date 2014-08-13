import Foundation

class Book {
    let title: String
    let pages: [Page]
    
    init(title: String, pages: [Page]) {
        self.title = title
        self.pages = pages
    }
}
