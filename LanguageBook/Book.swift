import Foundation

extension Book {
    /*{"title": "string", "pages": [{/* page */}, {/* page */}]}*/
    convenience init(json: JSONObjectType) {
        let dict = json as JSONDictionaryType
        let rawPages = dict["pages"]! as [JSONDictionaryType]

        let title = dict["title"]! as String
        let pages = rawPages.map { Page(json: $0) }
        self.init(title: title, pages: pages)
    }
}

class Book: Media {
    let title: String
    let pages: [Page]
    
    init(title: String, pages: [Page]) {
        self.title = title
        self.pages = pages
        
        let maxWidth = pages.max({ $0.frame.size.width }).frame.size.width
        let maxHeight = pages.min({ $0.frame.size.height }).frame.size.height
        let frame = FrameType(x: 0, y: 0, width: maxWidth, height: maxHeight)
        let intervals = IntervalType.union(pages.map { $0.interval })
        super.init(frame: frame, interval: intervals, children: pages)
    }
}
