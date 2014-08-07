import Foundation
import CoreMedia

extension CMTime {
    static func fromInterval(interval: NSTimeInterval) -> CMTime {
        return CMTimeMakeWithSeconds(interval, 1000000)
    }

    func toInterval() -> NSTimeInterval {
        return NSTimeInterval(self.value) / NSTimeInterval(self.timescale)
    }
}
