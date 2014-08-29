import Foundation

class SVGImageCache {
    class var sharedInstance: SVGImageCache {
        struct Static { static var instance: SVGImageCache = SVGImageCache() }
        return Static.instance
    }
    
    
    private var _cache: [String: SVGKImage] = [:]
    
    subscript(path: String) -> SVGKImage {
        return imageForPath(path)
    }
    
    func imageForPath(path: String) -> SVGKImage {
        if let copy = _cache[path] {
            return copy
        }
        
        let image = SVGKImage(contentsOfFile: path)
        _cache[path] = image
        return image
    }
    
}
