import UIKit

typealias DidChangeHandler = @autoclosure () -> ()

@objc protocol MediaController: Pausable {
    var playheadDidChange: DidChangeHandler? { get set }
    var playhead: AudioTime { get set }
    
    var scopeDidChange: DidChangeHandler? { get set }
    var scope: AudioInterval { get set }
}
