import Foundation

extension Page {
    // {"audio": "audio_filename.mp3", "frame": [/* frame */], "children": [{/* image or text */}]
    convenience init(json: JSONObjectType) {
        let dict = json as JSONDictionaryType
        let rawChildren = dict["children"]! as [JSONDictionaryType]

        let frame = Media.parseFrameType(json: dict["frame"]!)
        let audioName = dict["audio"]! as String
        let children: [Media] = rawChildren.map { child in
            if let image: AnyObject = child["image"] {
                return Image(json: child)
            } else if let text: AnyObject = child["text"] {
                return AnnotatedText(json: child)
            }
            
            fatalError("page children is nil or of unknown type.")
        }
        
        self.init(frame: frame, audioName: audioName, children: children)
    }
}

class Page: Media {
    let audioName: String
    
    init(frame: FrameType, audioName: String, children: [Media]) {
        self.audioName = audioName
        super.init(frame: frame, interval: nil, children: children)
    }
}
