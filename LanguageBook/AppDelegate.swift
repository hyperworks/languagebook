import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        let w = UIWindow(frame: UIScreen.mainScreen().bounds)
        w.backgroundColor = .whiteColor()
        w.rootViewController = RootViewController()
        w.makeKeyAndVisible()
        
        window = w
        return true
    }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        dump("applicationDidReceiveMemoryWarning")
        Notification.MemoryWarning.broadcast()
    }

    func applicationWillResignActive(application: UIApplication!) { }
    func applicationDidEnterBackground(application: UIApplication!) { }
    func applicationWillEnterForeground(application: UIApplication!) { }
    func applicationDidBecomeActive(application: UIApplication!) { }
    func applicationWillTerminate(application: UIApplication!) { }
}

