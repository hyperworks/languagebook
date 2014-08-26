import UIKit

extension ImageRegion {
    // {"frame": [/* frame */], "interval": [/* interval */]}
    convenience init(json: JSONObjectType) {
        let dict = json as JSONDictionaryType
        self.init(frame: Media.parseFrame(json: dict["frame"]!),
            interval: Media.parseInterval(json: dict["interval"]!))
    }
}

class ImageRegion: Media {
    init(frame: FrameType, interval: IntervalType) {
        super.init(frame: frame, interval: interval, children: [])
    }
}
