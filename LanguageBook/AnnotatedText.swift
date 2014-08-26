import UIKit

typealias OnPlayHandler = (range: AudioInterval) -> ()

protocol PlayheadController {
    var currentTime: AudioTime { get set }

    var onPlay: OnPlayHandler? { get set }
    func play(range: AudioInterval)
}

extension AnnotatedText {
    // {"text": "annotated |text |with |word |marks", "frame": [/* frame */],
    //  "times": [/* interval list */], "attributes": {/* attributes dictionary */}}
    convenience init(json: JSONObjectType) {
        let dict = json as JSONDictionaryType
        let wordMarkers = NSCharacterSet(charactersInString: "|")
        let words = (dict["text"]! as String).componentsSeparatedByCharactersInSet(wordMarkers)
        
        self.init(frame: Media.parseFrame(json: dict["frame"]!),
            attributes: AnnotatedText.parseAttributeDictionary(json: dict["attributes"]!),
            rawWords: words,
            intervals: AnnotatedText.parseIntervalList(json: dict["times"]!))
    }
    
    // {"font": "Tahoma", "color": "White"}
    class func parseAttributeDictionary(#json: JSONObjectType) -> AttributeDictionary {
        // TODO: Parse and map attributes
        let dict = json as JSONDictionaryType
        var result: AttributeDictionary = [:]
        
        if let fontName = dict["font"] {
            if let fontSize = dict["size"] {
                result[NSFontAttributeName] = UIFont(name: <#String#>, size: <#CGFloat#>)
            }
        }
    }
    
    // [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
    class func parseIntervalList(#json: JSONObjectType) -> IntervalListType {
        // TODO: parse array of dubles
    }
}

class AnnotatedText: Media {
    typealias AttributeDictionary = [NSObject: AnyObject]
    typealias IntervalListType = [IntervalType]
    
    private var _words: [Word] = []
    private var _wordStops: [Int] = []
        
    let textStorage: NSTextStorage
    let textContainer: NSTextContainer
    let layoutManager: NSLayoutManager
    
    var words: [Word] { return _words }
    
    // TODO: Pre-render text into sprites? Since then we'll be able to directly display the sprites
    //   and not have to re-layout and do this TextKit wrangling again. The AnnotatedText class
    //   could then be a simple subclass of ImageMedia with overridden hit-testing logic.
    init(frame: FrameType, attributes: AttributeDictionary, rawWords: [String], intervals: IntervalListType) {
        assert(rawWords.count == intervals.count, "number of words and times mismatch.")
        let fullText = "".join(rawWords)
        
        // TextKit setup
        let storage = NSTextStorage(string: fullText, attributes: attributes)
        let container = NSTextContainer(size: frame.size)
        let manager = NSLayoutManager()
        manager.addTextContainer(container)
        storage.addLayoutManager(manager)
        
        // Construct Word instances.
        let wordEnds = rawWords.scan(seed: 0) { $0 + countElements($1) }
        let wordRanges = wordEnds.scan(seed: 0...0) { $0.end...$1 }
        let words = wordRanges.zip(with: intervals).map({ (range, interval) -> Word in
            let frame = manager.boundingRectForGlyphRange(NSRange(range: range), inTextContainer: container)
            return Word(frame: frame, sourceText: storage, range: range, interval: interval)
        })
        
        self.textStorage = storage
        self.textContainer = container
        self.layoutManager = manager
        
        _words = words
        super.init(frame: frame, interval: nil, children: _words)
    }
}
