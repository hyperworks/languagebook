import UIKit

// Since we'll be doing a lot of CGPoint calculation, we might as well define all these
// arithmetic operators so we can have nice math.

@infix func +(a: CGPoint, b: CGPoint) -> CGPoint { return CGPoint(x: a.x + b.x, y: a.y + b.y) }
@infix func -(a: CGPoint, b: CGPoint) -> CGPoint { return CGPoint(x: a.x - b.x, y: a.y - b.y) }

@infix func *(a: CGPoint, b: CGSize) -> CGPoint { return a * CGPoint(x: b.width, y: b.height) }
@infix func *(a: CGPoint, b: CGPoint) -> CGPoint { return CGPoint(x: a.x * b.x, y: a.y * b.y) }
@infix func *(a: CGPoint, b: CGFloat) -> CGPoint { return CGPoint(x: a.x * b, y: a.y * b) }
@infix func *(a: CGPoint, b: Int) -> CGPoint { return a * CGFloat(b) }

@assignment func +=(inout a: CGPoint, b: CGPoint) { a = a + b }
@assignment func -=(inout a: CGPoint, b: CGPoint) { a = a - b }
