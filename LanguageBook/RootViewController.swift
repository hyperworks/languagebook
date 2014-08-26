import UIKit

class RootViewController: UIViewController {
    let book = Book.fromJSON() // TODO: ChapterViewController() for the main chapter.
    let pageViewController = PageViewController()
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        let v = UIView(frame: bounds)
        v.backgroundColor = .whiteColor()
        
        let pageView = pageViewController.view
        addChildViewController(pageViewController)
        
        v.addSubview(pageView)
        pageView.addConstraint(NSLayoutConstraint(item: pageView, width: bounds.size.width))
        pageView.addConstraint(NSLayoutConstraint(item: pageView, height: bounds.size.height))
        v.addConstraint(NSLayoutConstraint(verticalAlignItem: pageView, withItem: v))
        v.addConstraint(NSLayoutConstraint(horizontalAlignItem: pageView, withItem: v))
        pageViewController.didMoveToParentViewController(self)
        
        view = v
        
        dump(book, name: "loaded book")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.setViewControllers([DebugController()],
            direction: .Forward,
            animated: false,
            completion: nil)
    }
}
