import UIKit
import SpriteKit

class RootViewController: UIPageViewController, UIPageViewControllerDataSource,
    UIPageViewControllerDelegate, SceneNavigationDelegate {
    
    var currentSceneViewController: SceneViewController? = nil
    
    init() {
        super.init(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: [:])
        dataSource = self
        delegate = self
        
        setViewControllers([controllerFor(MainScene())], direction: .Forward,
            animated: false, completion: nil)
    }
    
    func controllerFor(scene: Scene) -> UIViewController {
        let controller = SceneViewController(scene)
        if let scene = controller.scene as? Scene {
            scene.navigationDelegate = self
        }
        
        return controller
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
            if let scene = ((viewController as? SceneViewController)?.scene as? NavigableScene)?.previousScene() {
                return controllerFor(scene)
            }
            
            return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
        viewControllerAfterViewController viewController: UIViewController!) -> UIViewController! {
            if let scene = ((viewController as? SceneViewController)?.scene as? NavigableScene)?.nextScene() {
                return controllerFor(scene)
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

