import UIKit

class Image: Media {
    let image: UIImage
    
    init(image: UIImage, regions: [ImageRegion]) {
        let interval = IntervalType.union(regions.map { $0.interval })
        self.image = image
        super.init(interval: interval, children: regions)
    }
}
