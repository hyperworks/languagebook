import AVFoundation
import CoreMedia

@objc protocol AudioControllerDelegate {
    func audioController(controller: AudioController, didReachBookmark bookmark: AudioController.TimeType)
}

class AudioController: AudioBase {
    private let _asset: AVAsset
    private var _player: AVPlayer? = nil
    private var _playerItem: AVPlayerItem? = nil
    private var _bookmarks: [TimeType] = []
    private var _nextBookmarkIndex: Array<TimeType>.Index = 0

    weak var delegate: AudioControllerDelegate?
    var bookmarks: [TimeType] { return _bookmarks }
    
    init(audioPath: String) {
        _asset = AVURLAsset(URL: NSURL.fileURLWithPath(audioPath), options: [:])
        _player?.pause()
        _player?.pause
    }
    
    func addBookmark(time: TimeType) { _bookmarks.append(time) }
    func clearBookmarks() { _bookmarks.removeAll(keepCapacity: true) }
    
    
    func play(range: IntervalType) { play(startAt: range.start, playUntil: range.end) }
    
    func play(startAt startTime: TimeType, playUntil endTime: TimeType) {
        stop()
        let item = AVPlayerItem(asset: _asset)
        item.seekToTime(CMTime.fromInterval(startTime))
        item.forwardPlaybackEndTime = CMTime.fromInterval(endTime)
        playItem(item)
    }
    
    func playFromBeginning() {
        stop()
        playItem(AVPlayerItem(asset: _asset))
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
            _playerItem!.observe("status", usingBlock: itemStatusDidChange)
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

    // TODO: We might be able to replace this with a doubly linked list or something where the next
    //   previous item can be easily linked to so that we can support fast seeking operation in the
    //   future.
    private func playerDidObserveTime(time: CMTime) {
        let interval = time.toInterval()
        if _nextBookmarkIndex >= _bookmarks.count { return }

        let bookmark = _bookmarks[_nextBookmarkIndex]
        if interval > bookmark {
            dump(bookmark, name: "hit bookmark")
            delegate?.audioController(self, didReachBookmark: bookmark)
            _nextBookmarkIndex += 1
        }
    }


    func stop() {
        _playerItem = nil
        _player?.pause()
        _player = nil
        _nextBookmarkIndex = 0
    }
}
