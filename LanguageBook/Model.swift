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
    
    
    class func loadJSON(name: String, inDirectory dir: String? = nil) -> AnyObject {
        let directory = dir == nil ? "Assets" : "Assets/\(dir!)"
        
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource(name, ofType: "json", inDirectory: directory)
        assert(path != nil, "failed to find json file: `\(name)` in dir: `\(directory)`")
        
        let data = NSData(contentsOfFile: path!)
        
        var error: NSError? = nil
        let opts: NSJSONReadingOptions = NSJSONReadingOptions.fromMask(0)
        let raw: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: opts, error: &error)
        assert(error == nil || raw == nil, "failed to parse json: `\(name)` in dir: `\(dir)` error: \(error)")
        
        return raw!
    }
}
