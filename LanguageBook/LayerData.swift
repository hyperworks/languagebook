import UIKit

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
    
    
    // TODO: Extension on CALayer crashes the editor so often it's annoying so I'm making these
    //   a standard/simple method instead.
    class func readFrom(layer: CALayer) -> LayerData? {
        return layer.valueForKey("LanguageBookData") as LayerData?
    }

    func writeTo(layer: CALayer) {
        layer.setValue(self, forKey: "LanguageBookData")
    }
}


