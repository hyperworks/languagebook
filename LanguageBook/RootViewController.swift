import UIKit
import SpriteKit

class RootViewController: UIPageViewController, UIPageViewControllerDataSource,
    UIPageViewControllerDelegate, SceneNavigationDelegate {
    
    init() {
        super.init(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: [:])
        doubleSided = false
        dataSource = self
        delegate = self

        let firstScene = MainScene()
        firstScene.navigationDelegate = self

        setViewControllers([firstScene.controller()], direction: .Forward,
            animated: false, completion: nil)
    }
    
    // MARK: SceneNavigationDelegate
    func scene(scene: Scene, shouldAdvanceTo nextScene: Scene) {
        nextScene.navigationDelegate = self
        setViewControllers([nextScene.controller()], direction: .Forward,
            animated: true, completion: nil)
    }
    
    func scene(scene: Scene, shouldReturnTo previousScene: Scene) {
        previousScene.navigationDelegate = self
        setViewControllers([previousScene.controller()], direction: .Reverse,
            animated: true, completion: nil)
    }
    
    // MARK: UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController!,
        viewControllerBeforeViewController viewController: UIViewController!) -> UIViewController! {
            let controller = viewController as SceneViewController
            let scene = controller.scene as? NavigableScene
            return scene?.previousScene()?.controller()
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
        viewControllerAfterViewController viewController: UIViewController!) -> UIViewController! {
            let controller = viewController as SceneViewController
            let scene = controller.scene as? NavigableScene
            return scene?.nextScene()?.controller()
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

