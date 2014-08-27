import UIKit
import QuartzCore

@objc class LayerDataLoader: NSObject {
    let image: SVGKImage
    
    init(image: SVGKImage) {
        self.image = image
    }
    
    func load() -> [CALayer] {
        var interactiveLayers: [CALayer] = []
        
        let allElements = image.DOMTree.getElementsByTagName("*")
        for var i = 0; i < allElements.length; i++ {
            let elem = allElements.item(Int32(i)) as Element
            let id = elem.getAttribute("id")
            if id == nil { continue }
            
            if let layer = image.layerWithIdentifier(id) {
                let data = LayerData(
                    scope: elem.hasAttribute("scope") ? parseScope(elem.getAttribute("scope")) : nil,
                    animation: elem.getAttribute("animation"),
                    link: elem.getAttribute("link")
                )
                
                data.writeTo(layer)
                interactiveLayers += [layer]
            }
        }
        
        resolveInheritance(image.CALayerTree)
        return interactiveLayers
    }
    
    private func resolveInheritance(layer: CALayer, var resolved: [String: Any] = [:]) {
        if let data = LayerData.readFrom(layer) {
            let resolvedData = LayerData(
                scope: inherits(&resolved, data.scope, AudioInterval(), "scope"),
                animation: inherits(&resolved, data.animation, "", "animation"),
                link: inherits(&resolved, data.link, "", "link")
            )
        
            resolvedData.writeTo(layer)
        }
        
        layer.sublayers?
            .cast({ $0 as? CALayer })
            .each({ self.resolveInheritance($0, resolved: resolved) })
    }
    
    private func inherits<T: Equatable>(inout resolved: [String: Any], _ value: T?, _ zeroValue: T, _ key: String) -> T? {
        if let v = value {
            if v != zeroValue {
                resolved[key] = v
                return v
            }
        }
        
        return resolved[key] as? T
    }
    
    
    private func parseScope(rawStr: String) -> AudioInterval {
        let components = rawStr.componentsSeparatedByString("-")
        var start = Double(0.0), end = Double(0.0)
        NSScanner.localizedScannerWithString(components[0]).scanDouble(&start)
        NSScanner.localizedScannerWithString(components[1]).scanDouble(&end)
        
        return AudioInterval(start: start, end: end)
    }
}
