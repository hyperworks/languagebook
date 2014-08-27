import UIKit

extension CALayer {
    var layerData: LayerData? {
        get { return self.valueForKey("LanguageBookData") as LayerData? }
        set { self.setValue(newValue, forKey: "LanguageBookData") }
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


