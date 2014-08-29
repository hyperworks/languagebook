import UIKit

class PageViewController: UIViewController, SerialController {
    let chapter: Chapter
    let page: Page
    
    let contentControllers: [ContentViewController]
    let syncer: MediaSynchronizer
    
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
        
        self.contentControllers = page.contents.map({ ContentViewController.fromContent($0) })
        self.syncer = MediaSynchronizer(medias: contentControllers)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let v = UIView(frame: CGRectMake(0, 0, 768, 1024))
        v.backgroundColor = .whiteColor()
        v.opaque = true
        
        for controller in contentControllers {
            let subview = controller.view
            addChildViewController(controller)
            v.addSubview(subview)
            v.addConstraint(NSLayoutConstraint(verticalAlignItem: subview, withItem: v))
            v.addConstraint(NSLayoutConstraint(horizontalAlignItem: subview, withItem: v))
            
            v.bringSubviewToFront(subview)
            controller.didMoveToParentViewController(self)
        }
        
        // TODO: Load each content and overlay them on top of each other.
        v.setTranslatesAutoresizingMaskIntoConstraints(false)
        v.addConstraint(NSLayoutConstraint(item: v, width: 768))
        v.addConstraint(NSLayoutConstraint(item: v, height: 1024))
        view = v
    }
}
