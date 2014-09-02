import Foundation
import AVFoundation

class AudioContent: Content {
    let name: String
    let autoplay: Bool
    
    lazy private(set) var asset: AVAsset = {
        return AVURLAsset(URL: self.fileURL, options: nil)
    }()
    
    override init(page: Page, dict: JSONDict) {
        name = dict["audio"]! as String
        autoplay = (dict["autoplay"] ?? false) as Bool
        super.init(page: page, id: name)
    }
}
