import UIKit
import SpriteKit

class RootViewController: UIPageViewController, UIPageViewControllerDataSource,
    UIPageViewControllerDelegate, SceneNavigationDelegate {
    
    required init(coder aDecoder: NSCoder!) { fatalError("KVC initializer not supported.") }

    override init() {
        super.init(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: [:])
        doubleSided = false
        dataSource = self
        delegate = self
        
        moveToScene(MainScene())
    }
    
    
    func moveToScene(scene: Scene,
        direction: UIPageViewControllerNavigationDirection = .Forward,
        animated: Bool = false) {
        
        scene.navigationDelegate = self
        setViewControllers([SceneViewController(scene)],
            direction: direction,
            animated: animated,
            completion: nil)
    }


    // MARK: SceneNavigationDelegate
    func scene(scene: Scene, shouldAdvanceTo nextScene: Scene) {
        moveToScene(nextScene, direction: .Forward, animated: true)
    }
    
    func scene(scene: Scene, shouldReturnTo previousScene: Scene) {
        moveToScene(previousScene, direction: .Reverse, animated: true)
    }
    
    
    // MARK: UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController!,
        viewControllerBeforeViewController viewController: UIViewController!) -> UIViewController! {
        let controller = viewController as SceneViewController
        let scene = controller.scene as NavigableScene
        return scene.hasPreviousScene ? SceneViewController(scene.previousScene) : nil
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
        viewControllerAfterViewController viewController: UIViewController!) -> UIViewController! {
        let controller = viewController as SceneViewController
        let scene = controller.scene as NavigableScene
        return scene.hasNextScene ? SceneViewController(scene.nextScene) : nil
    }
    
    
    // MARK: UIPageViewControllerDelegate
    func pageViewController(pageViewController: UIPageViewController!,
        spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation)
        -> UIPageViewControllerSpineLocation {
        return .Min
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
        willTransitionToViewControllers pendingViewControllers: [AnyObject]!) {
        
        viewControllers.cast({ $0 as? SceneViewController }).each({ $0.paused = true })
        pendingViewControllers.cast({ $0 as? SceneViewController }).each({ $0.paused = true })
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
        didFinishAnimating finished: Bool,
        previousViewControllers: [AnyObject]!,
        transitionCompleted completed: Bool) {
        
        viewControllers.cast({ $0 as? SceneViewController }).each({ $0.paused = false })
    }
}

