import Foundation
import AVFoundation

// TODO: Fix the assumption that all content controllers will have a view.
class AudioContentViewController: ContentViewController {
    private let _asset: AVAsset
    private var _item: AVPlayerItem? = nil
    private var _player: AVPlayer? = nil
    
    private var _timeObserver: AnyObject? = nil
    private var _statusObserver: BlockObserver? = nil
    
    let playheadResolution = 0.01
    let audioContent: AudioContent
    
    // TODO: Support playhead seeking. This is a bit complicated since we're doing the playhead
    //   updating in this class as well. Might be able to use some locking code from the
    //   MediaSynchronizer class, or only update private vars and manually fire change events.
    override var scope: AudioInterval { didSet { playScope(scope) } }
    override var paused: Bool { didSet { pauseStateDidChange() } }
    
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(AudioContent content: AudioContent) {
        audioContent = content
        _asset = content.asset
        
        super.init(content: content)
    }

    
    private func playScope(scope: AudioInterval) {
        let item = AVPlayerItem(asset: _asset)
        item.seekToTime(CMTime.fromInterval(scope.start))
        item.forwardPlaybackEndTime = CMTime.fromInterval(scope.end)
        playItem(item)
    }
    
    private func playThrough() {
        playItem(AVPlayerItem(asset: _asset))
    }
    
    private func playItem(item: AVPlayerItem) {
        stop()
        
        _item = item
        _player = AVPlayer(playerItem: item)
        
        let resolution = CMTime.fromInterval(playheadResolution)
        _timeObserver = _player?.addPeriodicTimeObserverForInterval(resolution,
            queue: dispatch_get_main_queue(),
            usingBlock: playerDidObserveTime)
        
        if item.status == .ReadyToPlay {
            _player!.play()
        } else {
            _statusObserver = _item!.observe("status") { self.itemReadyStateDidChange() }
            return
        }
    }
    
    private func stop() {
        _player?.pause()
        _player?.removeTimeObserver(_timeObserver?)
        _player = nil
        
        if let so = _statusObserver {
            _item?.removeObserver(so, forKeyPath: "status")
        }

        _item = nil
    }
    
    
    // MARK: KVO
    private func pauseStateDidChange() {
        if let p = _player {
            if paused { p.pause() } else { p.play() }
        }
    }
    
    private func itemReadyStateDidChange() {
        if _item == nil { return }
        let item = _item!
        
        switch item.status {
        case .ReadyToPlay: _player!.play()
        case .Failed: dump(item, name: "failed to play item.")

        case .Unknown:
            dump(item, name: "item has unknown status.")
            return
        }

        item.removeObserver(_statusObserver?, forKeyPath: "status")
        _statusObserver = nil
    }
    
    private func playerDidObserveTime(time: CMTime) {
        playhead = AudioTime(time.toInterval())
    }
}