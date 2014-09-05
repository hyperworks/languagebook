import Foundation

enum Notification: String {
    typealias Observation = NSObjectProtocol!
    
    case MemoryWarning = "th.co.hyperworks.MemoryWarning"
    
    func broadcast() {
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        
        center.postNotificationName(toRaw(), object: nil)
    }
    
    func observe(block: NSNotification -> ()) -> Observation {
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        
        return center.addObserverForName(toRaw(), object: nil, queue: queue) { block($0!) }
    }
    
    static func unobserve(token: Observation) {
        NSNotificationCenter.defaultCenter().removeObserver(token)
    }
}
