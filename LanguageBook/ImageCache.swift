import Foundation

// TODO: We can't inherit from Cache<T> directly since subclasses of generic classes must also be
//   generic. This is Swift limitation as of b7, it maybe removed in future version.
class ImageCache {
    class func get(path: String) -> UIImage {
        struct Static {
            static let cache = Cache<UIImage>({ UIImage(contentsOfFile: $0) })
        }

        return Static.cache[path]
    }
}
