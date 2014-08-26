import UIKit

class PageViewController: UIViewController, SerialController {
    let chapter: Chapter
    let page: Page
    
    let contentControllers: [ContentController] // TODO: Build lazily
    
    var nextViewController: UIViewController? {
        let nextIdx = find(chapter.pages, page)! + 1
        if nextIdx >= chapter.pages.count { return nil }
            
        return PageViewController(chapter: chapter, page: chapter.pages[nextIdx])
    }
    
    var previousViewController: UIViewController? {
        let prevIdx = find(chapter.pages, page)! - 1
        if prevIdx < 0 { return nil }
            
        return PageViewController(chapter: chapter, page: chapter.pages[prevIdx])
    }
    
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(chapter: Chapter, page: Page) {
        self.chapter = chapter
        self.page = page
        
        // TODO: Build this lazily.
        self.contentControllers = page.contents.map({ ContentController.fromContent($0) })
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        // TODO: Load each content and overlay them on top of each other.
        view = UIView()
    }
}
