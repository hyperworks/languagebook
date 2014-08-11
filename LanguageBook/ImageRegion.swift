import UIKit

class ImageRegion: Media {
    let region: CGRect
    
    init(region: CGRect, interval: IntervalType) {
        self.region = region
        super.init(interval: interval, children: [])
    }
}
