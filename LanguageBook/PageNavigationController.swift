import UIKit
import SpriteKit

class PageNavigationController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override init() {
        super.init(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: [:])
        doubleSided = false
        dataSource = self
        delegate = self
    }

    
    // MARK: UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController!,
        viewControllerBeforeViewController viewController: UIViewController!) -> UIViewController! {
        
        if let viewController = viewControllers![0] as? SerialController {
            return viewController.previousViewController
        }
            
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
        viewControllerAfterViewController viewController: UIViewController!) -> UIViewController! {
            
        if let viewController = viewControllers![0] as? SerialController {
            return viewController.nextViewController
        }
            
        return nil
    }
    
    
    // MARK: UIPageViewControllerDelegate
    func pageViewController(pageViewController: UIPageViewController!,
        spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation)
        -> UIPageViewControllerSpineLocation {
        return .Min
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
        willTransitionToViewControllers pendingViewControllers: [AnyObject]!) {
        
        viewControllers.cast({ $0 as? MediaController }).each({ $0.paused = true })
        pendingViewControllers.cast({ $0 as? MediaController }).each({ $0.paused = true })
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
        didFinishAnimating finished: Bool,
        previousViewControllers: [AnyObject]!,
        transitionCompleted completed: Bool) {
        
        viewControllers.cast({ $0 as? MediaController }).each({ $0.paused = false })
    }
}

