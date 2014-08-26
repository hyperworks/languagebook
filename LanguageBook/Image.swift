import UIKit

extension Image {
    // {"image": "image_filename.svg", "frame": [/* frame */], "regions": [{/* region */}]}
    convenience init(json: JSONObjectType) {
        let dict = json as JSONDictionaryType
        let rawRegions = dict["regions"]! as JSONArrayType

        self.init(imageName: dict["image"]! as String,
            frame: Media.parseFrame(json: dict["frame"]!),
            regions: rawRegions.map { ImageRegion(json: $0) })
    }
}

class Image: Media {
    let imageName: String
    
    init(imageName: String, frame: FrameType, regions: [ImageRegion]) {
        self.imageName = imageName
        super.init(frame: frame, interval: nil, children: regions)
    }
}
