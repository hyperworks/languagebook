import AVFoundation
import CoreMedia

@objc protocol AudioControllerDelegate {
    optional func audioController(controller: AudioController, didReachBookmark bookmark: NSTimeInterval)
}

class AudioController: NSObject {
    private let _asset: AVAsset
    
    private var _player: AVPlayer? = nil
    private var _playerItem: AVPlayerItem? = nil
    private var _bookmarks: [NSTimeInterval] = []
    private var _nextBookmarkIndex: Array<NSTimeInterval>.Index = 0

    weak var delegate: AudioControllerDelegate?
    var bookmarks: [NSTimeInterval] { return _bookmarks }
    
    init(audioPath: String) {
        _asset = AVURLAsset(URL: NSURL.fileURLWithPath(audioPath), options: [:])
    }
    
    func addBookmark(time: NSTimeInterval) { _bookmarks.append(time) }
    func clearBookmarks() { _bookmarks.removeAll(keepCapacity: true) }
    
    
    func playFromBeginning() {
        stop()
        playItem(AVPlayerItem(asset: _asset))
    }
    
    // REF: http://stackoverflow.com/questions/18203943/convert-from-nstimeinterval-to-cmtime-accurately#comment26688130_18203943
    func play(startAt startTime: NSTimeInterval, playUntil endTime: NSTimeInterval) {
        stop()
        let item = AVPlayerItem(asset: _asset)
        item.seekToTime(CMTime.fromInterval(startTime))
        item.forwardPlaybackEndTime = CMTime.fromInterval(endTime)
        playItem(item)
    }

    private func playItem(item: AVPlayerItem) {
        _playerItem = item

        _player = AVPlayer(playerItem: _playerItem)
        for bookmark in _bookmarks {
            _player?.addPeriodicTimeObserverForInterval(CMTime.fromInterval(0.10),
                queue: dispatch_get_main_queue(),
                usingBlock: playerDidObserveTime)
        }

        if _playerItem!.status == .ReadyToPlay {
            _player!.play()

        } else {
            _playerItem!.addObserver(self,
                forKeyPath: "status",
                options: NSKeyValueObservingOptions(0),
                context: nil)
        }
    }

    private func itemStatusDidChange() {
        if let pi = _playerItem? {
            if pi.status == .ReadyToPlay {
                pi.removeObserver(self, forKeyPath: "status")
                _player?.play()
            }
        }
    }

    // TODO: We could probably optimize this away by using some form of binary search tree.
    private func playerDidObserveTime(time: CMTime) {
        let interval = time.toInterval()
        if _nextBookmarkIndex >= _bookmarks.count { return }

        let bookmark = _bookmarks[_nextBookmarkIndex]
        if interval > bookmark {
            dump(bookmark, name: "hit bookmark")
            delegate?.audioController?(self, didReachBookmark: bookmark)
            _nextBookmarkIndex += 1
        }
    }


    func stop() {
        _playerItem = nil
        _player?.pause()
        _player = nil
        _nextBookmarkIndex = 0
    }


    // MARK: KVO
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
