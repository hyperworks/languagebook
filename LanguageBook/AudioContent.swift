import Foundation
import AVFoundation

class AudioContent: Content {
    private lazy var _asset: AVAsset = AVURLAsset(URL: self.fileURL, options: nil)
    
    let name: String
    let autoplay: Bool
    let scope: AudioInterval?
    
    var asset: AVAsset { return _asset }
    
    override init(page: Page, dict: JSONDict) {
        name = dict["audio"]! as String
        autoplay = (dict["autoplay"] ?? false) as Bool
        
        let raw: AnyObject? = dict["scope"]?
        if let str = raw as? String {
            scope = AudioInterval.parse(str)
        } else {
            scope = nil
        }
        
        super.init(page: page, id: name)
    }
}
