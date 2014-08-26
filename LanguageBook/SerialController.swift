import UIKit

@objc protocol SerialController: class {
    var nextViewController: UIViewController! { get }
    var previousViewController: UIViewController! { get }
}
