import Foundation

class Random {
    class func stir() {
        arc4random_stir()
    }
    
    class func int(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
}
