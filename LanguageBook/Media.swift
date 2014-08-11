import Foundation

class Media {
    typealias TimeType = NSTimeInterval
    typealias IntervalType = ClosedInterval<TimeType>

    let interval: IntervalType
    let children: [Media]
    
    init(interval: IntervalType, children: [Media]) {
        self.interval = interval
        self.children = children
    }
    
    func childrenAtInterval(interval: TimeType) -> [Media] {
        var results = children.filter { $0.interval ~= interval }
        results += children.flattenMap { $0.childrenAtInterval(interval) }
        return children.filter({ $0.interval ~= interval })
    }
}
