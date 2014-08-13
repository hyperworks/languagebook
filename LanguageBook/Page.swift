import Foundation

class Page: Media {
    let audioName: String
    
    init(frame: FrameType, audioName: String, children: [Media]) {
        self.audioName = audioName
        super.init(frame: frame, interval: nil, children: children)
    }
}
