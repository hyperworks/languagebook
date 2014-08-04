import UIKit

// Needs to be a full class since we can't pass structs to protocols marked @objc
//   (which is effectively all protocols until Apple rewrites everything into Swift)
class TextPortion: NSObject {
    let time: Float
    let word: String
    
    init(time: Float, word: String) {
        self.time = time
        self.word = word
    }
}
