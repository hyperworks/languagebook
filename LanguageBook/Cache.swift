import Foundation

class Cache<T> {
    private var _memoryWarning: Notification.Observation
    private var _cache: [String: T] = [:]
    
    let factory: (path: String) -> T
    
    init(factory: String -> T) {
        self.factory = factory
        _memoryWarning = Notification.MemoryWarning.observe(didReceiveMemoryWarning)
    }
    
    deinit {
        Notification.unobserve(_memoryWarning)
    }
    
    
    subscript(path: String) -> T {
        return objectForPath(path)
    }
    
    func objectForPath(path: String) -> T {
        if let obj = _cache[path] {
            return obj
        }
        
        let instance = factory(path: path)
        _cache[path] = instance
        return instance
    }
    
    
    func didReceiveMemoryWarning(notification: NSNotification) {
        _cache.removeAll(keepCapacity: true)
    }
}
