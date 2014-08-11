import Foundation

extension ClosedInterval {
    static func union(intervals: [ClosedInterval]) -> ClosedInterval {
        let minStart = intervals.min({ $0.start }).start
        let maxEnd = intervals.max({ $0.end }).end
        return minStart...maxEnd
    }
}

extension HalfOpenInterval {
    static func union(intervals: [HalfOpenInterval]) -> HalfOpenInterval {
        let minStart = intervals.min({ $0.start }).start
        let maxEnd = intervals.max({ $0.end }).end
        return minStart..<maxEnd
    }
}
