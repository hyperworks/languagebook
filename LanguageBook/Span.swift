import Foundation

// The native Swift Range type requires ForwardIndex protocol compliance which means we cannot use
// it with Float(s) so we're avoiding that by rolling our own range/span type here.
// TODO: Remove this and use the Beta5's Interval<T> type.
struct Span<T> {
    var from: T
    var to: T
}