import UIKit

class ChapterViewController: PageNavigationController {
    let book: Book
    let chapter: Chapter
    
    let pageControllers: [PageViewController]
    
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(book: Book, chapter: Chapter) {
        self.book = book
        self.chapter = chapter
        
        // TODO: Build this lazily
        pageControllers = chapter.pages.map({ PageViewController(chapter: chapter, page: $0) })
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if chapter.pages.count == 0 {
            dump(chapter, name: "chapter has no pages")
            return
        }
        
        let firstPage = chapter.pages[0]
        setViewControllers([PageViewController(chapter: chapter, page: firstPage)],
            direction: .Forward,
            animated: false,
            completion: nil)
    }
}
