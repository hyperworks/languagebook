import Foundation

@objc class Model: NSObject {
    let id: String
    
    typealias JSONArray = [AnyObject]
    typealias JSONDict = [String: AnyObject] // might need to be [NSObject: AnyObject]
    
    init(dict: JSONDict) {
        self.id = (dict["id"] ?? "(unknown)") as String
        super.init()
    }
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    
    class func pathForName(name: String, inDirectory dir: String?) -> String {
        let bundle = NSBundle.mainBundle()
        let subdir = dir == nil ? "Assets" : "Assets/\(dir!)"
        dump(subdir, name: "dir")
        
        return bundle.pathForResource(name, ofType: nil, inDirectory: subdir)!
    }
    
    class func loadJSON(name: String, inDirectory dir: String? = nil) -> AnyObject {
        let path = pathForName(name, inDirectory: dir)
        let data = NSData(contentsOfFile: path)
        
        var error: NSError? = nil
        let opts: NSJSONReadingOptions = NSJSONReadingOptions.fromMask(0)
        let raw: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: opts, error: &error)
        assert(error == nil || raw == nil, "failed to parse json: `\(name)` in dir: `\(dir)` error: \(error)")
        
        return raw!
    }
}
