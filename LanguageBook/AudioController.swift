import AVFoundation
import CoreMedia

@objc protocol AudioControllerDelegate {
    optional func audioController(controller: AudioController, didReachBookmark: NSTimeInterval)
}

class AudioController: NSObject {
    private let _asset: AVAsset
    
    private var _player: AVPlayer? = nil
    private var _bookmarks: [NSTimeInterval] = []
    
    var bookmarks: [NSTimeInterval] { return _bookmarks }
    
    init(audioPath: String) {
        _asset = AVAsset.assetWithURL(NSURL.fileURLWithPath(audioPath)) as AVAsset
    }
    
    func addBookmark(time: NSTimeInterval) { _bookmarks.append(time) }
    func clearBookmarks() { _bookmarks.removeAll(keepCapacity: true) }
    
    
    func playFromBeginning() {
        stop()
        
        _player = AVPlayer(playerItem: AVPlayerItem(asset: _asset))
        _player?.play()
    }
    
    // REF: http://stackoverflow.com/questions/18203943/convert-from-nstimeinterval-to-cmtime-accurately#comment26688130_18203943
    func play(startAt startTime: NSTimeInterval, playUntil endTime: NSTimeInterval) {
        stop()
        
        let cmStartTime = CMTimeMakeWithSeconds(startTime, 1000000)
        let cmEndTime = CMTimeMakeWithSeconds(endTime, 1000000)
        let duration = CMTimeMakeWithSeconds((endTime - startTime), 1000000)
        dump(duration, name: "duration")
        
        let range = CMTimeRangeFromTimeToTime(cmStartTime, cmEndTime)
        let composition = AVMutableComposition()
        let result = composition.insertTimeRange(range,
            ofAsset: _asset,
            atTime: CMTimeMake(0, 1),
            error: nil)
        assert(result, "composition failed.")
        
        let item = AVPlayerItem(asset: composition.copy() as AVComposition)
        _player = AVPlayer(playerItem: item)
        _player?.seekToTime(CMTimeMake(0, 1))
        _player?.play()
    }
    
    func stop() {
        _player?.pause()
        _player = nil
    }
}
