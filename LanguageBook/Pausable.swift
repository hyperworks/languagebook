import Foundation

@objc protocol Pausable: class {
    var paused: Bool { get set }
}
