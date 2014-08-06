import UIKit

class MarkedStringLoader {
    typealias SubtitleLine = (index: Int, fromTime: Float, toTime: Float, line: String)
    
    let scriptPath: String
    let attributes: [NSObject : AnyObject]
    let subtitlePath: String
    let audioPath: String
    
    convenience init(setName: String, attributes: [NSObject : AnyObject]? = nil) {
        self.init(bundle: NSBundle.mainBundle(), setName: setName, attributes: attributes)
    }
    
    init(bundle: NSBundle, setName: String, attributes: [NSObject : AnyObject]? = nil) {
        (scriptPath, subtitlePath, audioPath) = (
            bundle.pathForResource(setName, ofType: ".txt"),
            bundle.pathForResource(setName, ofType: ".srt"),
            bundle.pathForResource(setName, ofType: ".mp3")
        )
        
        if let a = attributes {
            self.attributes = a
        } else {
            self.attributes = [:]
        }
    }
    
    
    func load() -> MarkedString {
        let script = loadScript()
        let subtitles = loadSubtitle()
        let wordSpans = correlateScriptAndSubtitle(script, subtitle: subtitles)
        let portions = map(Zip2(wordSpans, subtitles), { (word, subtitle) in
            TextPortion(fromIndex: word.from,
                toIndex: word.to,
                fromTime: subtitle.fromTime,
                toTime: subtitle.toTime)
        })
        
        return MarkedString(script: NSAttributedString(string: script, attributes: attributes),
            audioPath: audioPath,
            portions: portions)
    }
    
    func loadScript() -> String {
        return NSString(contentsOfFile: scriptPath,
            encoding: NSUTF8StringEncoding,
            error: nil)
    }
    
    func loadSubtitle() -> [SubtitleLine] {
        let contents = NSString(contentsOfFile: subtitlePath,
            encoding: NSUTF8StringEncoding,
            error: nil)
        
        // TODO: Can probably replace this easily with a simple recursive descent parser. Then we
        //   can also extract and open source the thing as well.
        let groups = contents.componentsSeparatedByString("\n\n")
        var results: [SubtitleLine] = []
        for group in groups {
            let lines = group.componentsSeparatedByString("\n") as [String]
            if lines.count < 3 { continue }
            
            let index = lines[0].toInt()!
            let times = lines[1].componentsSeparatedByString(" --> ") as [String]
            let text = " ".join(lines[2..<lines.count])
            let (startTime, endTime) = (
                parseSubtitleTime(times[0]),
                parseSubtitleTime(times[1])
            )
            
            results.append((index, startTime, endTime, text))
        }
        
        return results
    }
    
    func correlateScriptAndSubtitle(script: String, subtitle lines: [SubtitleLine]) -> [Span<String.Index>] {
        let whitespaces = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        var queue = Slice(lines)
        var length = countElements(script)
        var scope = Range(start: script.startIndex, end: script.endIndex)
        var results: [Span<String.Index>] = []
        
        while !queue.isEmpty {
            let line = queue[0].line
            let occurence = script.rangeOfString(line,
                options: .CaseInsensitiveSearch | .DiacriticInsensitiveSearch,
                range: scope, locale: nil)
            
            assert(occurence, "failed to correlate script to subtitle.")
            
            let o = occurence!
            results.append(Span(from: o.startIndex, to: o.endIndex))
            
            scope.startIndex = o.endIndex
            queue = dropFirst(queue)
        }
        
        return results
    }
    
    
    private func parseSubtitleTime(timeString: String) -> Float {
        // sample time: 00:00:31,866
        let pattern = "([0-9]{2}):([0-9]{2}):([0-9]{2}),([0-9]{3,})"

        let rx = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions(0), error: nil)
        let matches = rx.matchesInString(timeString,
            options: NSMatchingOptions(0),
            range: NSRange(location: 0, length: countElements(timeString))) as [NSTextCheckingResult]
        let match = matches[0]

        let nums = [1, 2, 3, 4]
            .map({ match.rangeAtIndex(Int($0)) })
            .map({ $0.toStringRange(inString: timeString) })
            .map({ timeString.substringWithRange($0).toInt()! })

        var seconds: Float = Float(nums[3]) / powf(10.0, Float(nums[3].numberOfDigits))
        seconds += Float(nums[2])
        seconds += Float(nums[1] * 60)
        seconds += Float(nums[0] * 60 * 60)
        
        return seconds
    }
}
