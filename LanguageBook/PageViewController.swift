import UIKit

class PageViewController: UIViewController, SerialController {
    let chapter: Chapter
    let page: Page
    
    let contentControllers: [ContentViewController]
    let contentSize: CGSize
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
        
        func maximumContentSize() -> CGSize {
            var maxWidth: CGFloat = 0
            var maxHeight: CGFloat = 0

            for content in page.contents {
                let dim = content.dimension
                maxWidth = dim.width > maxWidth ? dim.width : maxWidth
                maxHeight = dim.height > maxHeight ? dim.height : maxHeight
            }

            return CGSize(width: maxWidth, height: maxHeight)
        }

        contentControllers = page.contents.map({ ContentViewController.fromContent($0) })
        contentSize = maximumContentSize()
        syncer = MediaSynchronizer(medias: contentControllers)
        super.init(nibName: nil, bundle: nil)

    }
    
    override func loadView() {
        let screenSize = UIScreen.rotatedSize()
        let v = UIView(frame: CGRect(origin: CGPointZero, size: screenSize))
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

        v.autoresizingMask = .FlexibleWidth | .FlexibleHeight | .FlexibleTopMargin | .FlexibleBottomMargin
        view = v
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        adjustContentViewScaleToOrientation(UIApplication.sharedApplication().statusBarOrientation)
    }

    private func adjustContentViewScaleToOrientation(orientation: UIInterfaceOrientation) {
        let targetSize = UIScreen.sizeInOrientation(orientation)
        let scale = contentScaleAtSize(targetSize)

        let layer = view.layer
        layer.transform = CATransform3DMakeScale(scale, scale, 1.0)
    }


    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        adjustContentViewScaleToOrientation(toInterfaceOrientation)
    }


    private func contentScaleAtSize(size: CGSize) -> CGFloat {
        let targetAspect = size.width / size.height
        let contentAspect = contentSize.width / contentSize.height

        if contentAspect > targetAspect {
            return size.width / contentSize.width
        } else {
            return size.height / contentSize.height
        }
    }
}
