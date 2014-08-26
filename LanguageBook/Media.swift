import UIKit

extension Media {
    // [{/* book */}]
    typealias JSONObjectType = AnyObject
    typealias JSONDictionaryType = [String: JSONObjectType]
    typealias JSONArrayType = [JSONObjectType]

    // [10, 20, 640, 480]
    class func parseFrame(#json: Media.JSONObjectType) -> Media.FrameType {
        let arr = json as Media.JSONArrayType
        assert(arr.count == 4, "json object representing the frame must be an array of exactly 4 elements")

        return Media.FrameType(x: arr[0] as Int,
            y: arr[1] as Int,
            width: arr[2] as Int,
            height: arr[3] as Int)
    }
    
    // [0.365, 3.123]
    class func parseInterval(#json: Media.JSONObjectType) -> Media.IntervalType {
        let arr = json as Media.JSONArrayType
        let start = arr[0] as Double
        let end = arr[1] as Double
        return start...end
    }
}

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
        return results
    }
    
    func hitTest(point: PointType) -> Media? {
        fatalError("TODO: not yet implemented.")
        return nil
    }
}
