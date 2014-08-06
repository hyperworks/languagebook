import Foundation

extension Int {
    var numberOfDigits: Int { // TODO: Something more correct.
        var (digits, bounds) = (1, 10)
        while (self >= bounds) {
            digits += 1
            bounds *= 10
        }
            
        return digits
    }
}

