import UIKit

class Image: Media {
    let image: UIImage
    
    init(image: UIImage, frame: FrameType, regions: [ImageRegion]) {
        self.image = image
        super.init(frame: frame, interval: nil, children: regions)
    }
}
