import UIKit
import QuartzCore

extension CALayer {
    var layerData: LayerData? {
        get { return valueForKey("LanguageBookData") as LayerData? }
        set { setValue(newValue, forKey: "LanguageBookData") }
    }
}

@objc class LayerData: NSObject {
    let scope: AudioInterval?
    let animation: String?
    let link: String?
    
    init(scope: AudioInterval?,
        animation: String?,
        link: String?) {
        self.scope = scope
        self.animation = animation
        self.link = link
        super.init()
    }
}


