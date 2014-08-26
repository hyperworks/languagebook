import UIKit

class RootViewController: UIViewController {
    let book = Book.fromJSON()
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        let v = UIView(frame: bounds)
        v.backgroundColor = .whiteColor()
        
        // TODO: Load first chapter view.
        let chapterController = ChapterViewController(book: book, chapter: book.chapters[0])
        let chapterView = chapterController.view
        addChildViewController(chapterController)
        
        v.addSubview(chapterView)
        chapterView.addConstraint(NSLayoutConstraint(item: chapterView, width: bounds.size.width))
        chapterView.addConstraint(NSLayoutConstraint(item: chapterView, height: bounds.size.height))
        v.addConstraint(NSLayoutConstraint(verticalAlignItem: chapterView, withItem: v))
        v.addConstraint(NSLayoutConstraint(horizontalAlignItem: chapterView, withItem: v))
        chapterController.didMoveToParentViewController(self)
        
        view = v
    }
}
