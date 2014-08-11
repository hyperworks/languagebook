import Foundation

class AnnotatedText: Media {
    let attributedString: NSAttributedString
    
    init(_ attributedString: NSAttributedString, words: [Word]) {
        let interval = IntervalType.union(words.map { $0.interval })
        self.attributedString = attributedString
        super.init(interval: interval, children: words)
    }
}
