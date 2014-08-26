import UIKit

class Page: Model {
    let contents: [Content]
    
    override init(dict: JSONDict) {
        contents = (dict["contents"]! as JSONArray)
            .map({ Content.fromJSON($0 as JSONDict) })
        
        super.init(dict: dict)
    }
}
