import UIKit

class RootViewController: UIViewController {
    let book = Book.fromJSON()

    override func supportedInterfaceOrientations() -> Int {
        var mask: UIInterfaceOrientationMask = .Portrait | .PortraitUpsideDown |
            .LandscapeLeft | .LandscapeRight
        return Int(mask.toRaw())
    }
    
    override func loadView() {
        let v = UIView(frame: CGRect(origin: CGPointZero, size: UIScreen.rotatedSize()))
        v.backgroundColor = .whiteColor()

        // Load first chapter, if there are multiple chapters, the first one should acts as a menu.
        // TODO: Multi-chapter support + ability to navigate between them.
        let chapterController = ChapterViewController(book: book, chapter: book.chapters[0])
        addChildViewController(chapterController)

        let chapterView = chapterController.view
        chapterView.setTranslatesAutoresizingMaskIntoConstraints(false)

        v.addSubview(chapterView)
        v.addConstraint(NSLayoutConstraint(verticalAlignItem: chapterView, withItem: v))
        v.addConstraint(NSLayoutConstraint(horizontalAlignItem: chapterView, withItem: v))
        v.addConstraint(NSLayoutConstraint(sizeItem: chapterView, widthEqualsToItem: v))
        v.addConstraint(NSLayoutConstraint(sizeItem: chapterView, heightEqualsToItem: v))
        chapterController.didMoveToParentViewController(self)

        v.setTranslatesAutoresizingMaskIntoConstraints(true)
        v.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        view = v
    }
}
