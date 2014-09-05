import Foundation

class Config {
    class var defaultConfig: Config {
        struct Static { static var instance: Config = Config() }
        return Static.instance
    }
    
    // TODO: Read from build settings or xcconfig or something.
#if DEBUG
    let activeTags = ["en", "th"]
#else
    let activeTags = ["en", "ja"]
#endif
    
    private init() { }
}