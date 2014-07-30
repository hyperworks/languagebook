import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let w = window {
            w.backgroundColor = .whiteColor()
            w.rootViewController = RootViewController()
            w.makeKeyAndVisible()
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication!) { }
    func applicationDidEnterBackground(application: UIApplication!) { }
    func applicationWillEnterForeground(application: UIApplication!) { }
    func applicationDidBecomeActive(application: UIApplication!) { }
    func applicationWillTerminate(application: UIApplication!) { }
}

