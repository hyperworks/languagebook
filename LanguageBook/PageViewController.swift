import UIKit

class PageViewController: UIViewController, SerialController {
    let chapter: Chapter
    let page: Page
    
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
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let v = UIView(frame: CGRectMake(0, 0, 100, 100))
        v.setTranslatesAutoresizingMaskIntoConstraints(false)
        v.backgroundColor = .whiteColor()
        
        let contentControllers = page.contents.map({ ContentController.fromContent($0) })
        for controller in contentControllers {
            let subview = controller.view
            addChildViewController(controller)
            
            v.addSubview(subview)
            v.bringSubviewToFront(subview)
            
            v.addConstraint(NSLayoutConstraint(verticalAlignItem: subview, withItem: v))
            v.addConstraint(NSLayoutConstraint(horizontalAlignItem: subview, withItem: v))
            v.addConstraint(NSLayoutConstraint(sizeItem: subview, widthEqualsToItem: v))
            v.addConstraint(NSLayoutConstraint(sizeItem: subview, heightEqualsToItem: v))
            controller.didMoveToParentViewController(self)
        }
        
        // TODO: Load each content and overlay them on top of each other.
        view = v
    }
}
