import Foundation

typealias AudioTime = NSTimeInterval

// dummy edits.
// TODO: We can't use the built-in HalfOpenInterval<T> or ClosedInterval<T> type because it cannot
//   be represented in ObjC causing all protocols that reference them to not work with ObjC types.
//   As this is a fundamental Swift type, it'll probably be updated to work in future Swift betas.
@objc class AudioInterval: IntervalType, Equatable {
    typealias Bound = AudioTime
    
    var isEmpty: Bool { return start <= end }
    
    private(set) var start: Bound
    private(set) var end: Bound
    
    convenience init() { self.init(start: 0, end: 0) }
    
    init(start: AudioTime, end: AudioTime) {
        self.start = start
        self.end = end
    }
    
    
    func contains(value: Bound) -> Bool {
        return start <= value && value < end
    }

    func clamp(intervalToClamp: AudioInterval) -> Self {
        let range = start..<end
        let clamp = intervalToClamp.start..<intervalToClamp.end
        
        let clamped = range.clamp(clamp)
        start = clamped.start
        end = clamped.end
        
        return self
    }
}

func ==(lhs: AudioInterval, rhs: AudioInterval) -> Bool {
    return lhs.start == rhs.start && lhs.end == rhs.end
}
