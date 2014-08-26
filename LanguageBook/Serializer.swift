import Foundation

class Serializer {
    private init() { }
    
    class var sharedInstace: Serializer {
        struct Shared {
            static var instance: Serializer? = nil
        }
            
        if let result = Shared.instance {
            return result
        }
            
        Shared.instance = Serializer()
        return Shared.instance!
    }
    
    // TODO: serializeBook counterpart?
    func deserializeBooks(inputStream: NSInputStream) -> [Book] {
        let raw: AnyObject! = NSJSONSerialization.JSONObjectWithStream(inputStream,
            options: NSJSONReadingOptions(0),
            error: nil)
        
        switch raw {
        case nil:
            return []
        case let dict as NSDictionary:
            return [Book(json: dict)]
        case let list as NSArray:
                let arr: [AnyObject] = list
                return arr.map { Book(json: $0 as Media.JSONObjectType) }
        default:
            return []
        }
    }
}
