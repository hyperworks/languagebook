import Foundation

extension UIScreen {
    class func rotatedSize() -> CGSize {
        let size = UIScreen.mainScreen().bounds.size
        let orientation = UIApplication.sharedApplication().statusBarOrientation

        if UIInterfaceOrientationIsPortrait(orientation) && size.width < size.height {
            return size
        } else {
            return CGSizeMake(size.height, size.width)
        }
    }

    class func sizeInOrientation(orientation: UIInterfaceOrientation) -> CGSize {
        let size = rotatedSize()
        var rotated = CGSizeMake(size.height, size.width)

        switch orientation {
        case .Portrait, .PortraitUpsideDown:
            return size.width > size.height ? rotated : size
        case .LandscapeLeft, .LandscapeRight:
            return size.width > size.height ? size : rotated

        default: return size
        }
    }
}
