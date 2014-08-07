import AVFoundation
import CoreMedia

@objc protocol AudioControllerDelegate {
    optional func audioController(controller: AudioController, didReachBookmark: NSTimeInterval)
}

class AudioController: NSObject {
    private let _asset: AVAsset
    
    private var _player: AVPlayer? = nil
    private var _playerItem: AVPlayerItem? = nil
    private var _bookmarks: [NSTimeInterval] = []
    
    var bookmarks: [NSTimeInterval] { return _bookmarks }
    
    init(audioPath: String) {
        _asset = AVURLAsset(URL: NSURL.fileURLWithPath(audioPath), options: [:])
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

        _playerItem = AVPlayerItem(asset: _asset)
        _playerItem!.seekToTime(cmStartTime)
        _playerItem!.forwardPlaybackEndTime = cmEndTime
        _player = AVPlayer(playerItem: _playerItem)

        if _playerItem!.status == .ReadyToPlay {
            dump("playing", name: "status")
            _player!.play()

        } else {
            dump("adding observer", name: "status")
            _playerItem!.addObserver(self,
                forKeyPath: "status",
                options: NSKeyValueObservingOptions(0),
                context: nil)
        }
    }

    func itemStatusDidChange() {
        if let pi = _playerItem? {
            if pi.status == .ReadyToPlay {
                dump("playing", name: "status")
                pi.removeObserver(self, forKeyPath: "status")
                _player?.play()
            }
        }
    }


    func stop() {
        _playerItem = nil
        _player?.pause()
        _player = nil
    }


    override func observeValueForKeyPath(keyPath: String!,
        ofObject object: AnyObject!,
        change: [NSObject : AnyObject]!,
        context: UnsafeMutablePointer<()>) {

        let item = object as? AVPlayerItem
        if item == _playerItem && keyPath == "status" {
            itemStatusDidChange()
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
}
