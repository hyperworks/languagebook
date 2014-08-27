import UIKit

extension NSLayoutConstraint {

    // MARK: Alignments
    convenience init(horizontalAlignItem item: UIView, withItem another: UIView) {
        self.init(item: item,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: another,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0.0)
    }
    
    convenience init(verticalAlignItem item: UIView, withItem another: UIView) {
        self.init(item: item,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: another,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0.0)
    }


    // MARK: Anchors
    convenience init(topAnchor item: UIView, toItem another: UIView, padding: CGFloat = 0) {
        self.init(item: item,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: another,
            attribute: .Top,
            multiplier: 1.0,
            constant: padding)
    }

    convenience init(bottomAnchor item: UIView, toItem another: UIView, padding: CGFloat = 0) {
        self.init(item: item,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: another,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: padding)
    }

    convenience init(leftAnchor item: UIView, toItem another: UIView, padding: CGFloat = 0) {
        self.init(item: item,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: another,
            attribute: .Left,
            multiplier: 1.0,
            constant: padding)
    }

    convenience init(rightAnchor item: UIView, toItem another: UIView, padding: CGFloat = 0) {
        self.init(item: item,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: another,
            attribute: .Right,
            multiplier: 1.0,
            constant: padding)
    }
    

    // MARK: Sizing
    convenience init(item: UIView, width: CGFloat) {
        self.init(item: item,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Width,
            multiplier: 1.0,
            constant: width)
    }
    
    convenience init(item: UIView, height: CGFloat) {
        self.init(item: item,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Height,
            multiplier: 1.0,
            constant: height)
    }

    convenience init(sizeItem item: UIView, widthEqualsToItem another: UIView) {
        self.init(item: item,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: another,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0.0)
    }

    convenience init(sizeItem item: UIView, heightEqualsToItem another: UIView) {
        self.init(item: item,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: another,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0.0)
    }
}