import UIKit

class Media {
    typealias FrameType = CGRect
    typealias PointType = CGPoint
    typealias TimeType = NSTimeInterval
    typealias IntervalType = ClosedInterval<TimeType>

    let frame: CGRect
    let interval: IntervalType
    let children: [Media]
    
    init(frame: FrameType, interval: IntervalType!, children: [Media]) {
        self.frame = frame
        self.interval = interval ?? IntervalType.union(children.map { $0.interval })
        self.children = children
    }
    
    func childrenAtInterval(interval: TimeType) -> [Media] {
        var results = children.filter { $0.interval ~= interval }
        results += children.flattenMap { $0.childrenAtInterval(interval) }
        return children.filter({ $0.interval ~= interval })
    }
    
    func hitTest(point: PointType) -> Media? {
        fatalError("TODO: not yet implemented.")
        return nil
    }
}
