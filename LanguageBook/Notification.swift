import Foundation

typealias ObservationToken = NSObjectProtocol!

enum Notification: String {
    case MemoryWarning = "th.co.hyperworks.MemoryWarning"
    
    static func observe(notif: Notification, block: NSNotification -> ()) -> ObservationToken {
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        
        return center.addObserverForName(notif.toRaw(), object: nil, queue: queue) { block($0!) }
    }
    
    static func unobserve(token: ObservationToken) {
        NSNotificationCenter.defaultCenter().removeObserver(token)
    }
}
