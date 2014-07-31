import UIKit
import SpriteKit

class RootViewController: UIPageViewController, UIPageViewControllerDataSource,
    UIPageViewControllerDelegate, SceneNavigationDelegate {
    
    var currentSceneViewController: SceneViewController? = nil
    
    init() {
        super.init(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: [:])
        doubleSided = false
        dataSource = self
        delegate = self
        
        setViewControllers([controllerFor(MainScene())], direction: .Forward,
            animated: false, completion: nil)
    }
    
    func controllerFor(scene: Scene?) -> UIViewController! {
        if let nav = scene as? NavigableScene {
            nav.navigationDelegate = self
            return SceneViewController(nav)
        }

        return nil
    }
    
    // MARK: SceneNavigationDelegate
    func scene(scene: Scene, shouldAdvanceTo nextScene: Scene) {
        setViewControllers([controllerFor(nextScene)], direction: .Forward,
            animated: true, completion: nil)
    }
    
    func scene(scene: Scene, shouldReturnTo previousScene: Scene) {
        setViewControllers([controllerFor(previousScene)], direction: .Reverse,
            animated: true, completion: nil)
    }
    
    // MARK: UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController!,
        viewControllerBeforeViewController viewController: UIViewController!) -> UIViewController! {
            let controller = viewController as SceneViewController
            let scene = controller.scene as? NavigableScene
            return controllerFor(scene?.previousScene())
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
        viewControllerAfterViewController viewController: UIViewController!) -> UIViewController! {
            let controller = viewController as SceneViewController
            let scene = controller.scene as? NavigableScene
            return controllerFor(scene?.nextScene())
    }
    
    // MARK: UIPageViewControllerDelegate
    func pageViewController(pageViewController: UIPageViewController!,
        spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation)
        -> UIPageViewControllerSpineLocation {
        return .Min
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
            willTransitionToViewControllers pendingViewControllers: [AnyObject]!) {
            for controller in viewControllers {
            if let c = controller as? SceneViewController {
                c.paused = true
            }
        }
        for controller in pendingViewControllers {
            if let c = controller as? SceneViewController {
                c.paused = true
            }
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
                didFinishAnimating finished: Bool, previousViewControllers: [AnyObject]!,
                transitionCompleted completed: Bool) {
        for controller in viewControllers {
            if let c = controller as? SceneViewController {
                c.paused = false
            }
        }
    }
}

