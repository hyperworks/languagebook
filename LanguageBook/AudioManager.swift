import Foundation

protocol AudioManagerDelegate {
    func audioManager(manager: AudioManager, didReachBookmark bookmark: AudioManager.TimeType, ofAudio audio: String)
    func audioManager(manager: AudioManager, didBeginPlayingAudio audio: String, interval: AudioManager.IntervalType)
    func audioManager(manager: AudioManager, didStopPlayingAudio audio: String, interval: AudioManager.IntervalType)
}

extension AudioManager {
    class var sharedInstance: AudioManager {
        struct Shared { static var instance: AudioManager? = nil }
        
        Shared.instance = Shared.instance ?? AudioManager()
        return Shared.instance!
    }
}

class AudioManager: AudioBase, AudioControllerDelegate {
    private let _controllers: [String: AudioController] = Dictionary(minimumCapacity: 5)
    private let _memoryWarning: ObservationToken
    
    private(set) var selectedAudio: String? = nil
    private(set) var selectedTimeInterval: IntervalType? = nil
    
    var selectedAudioController: AudioController? {
        return selectedAudio == nil ? nil : _controllers[selectedAudio!]
    }
    
    override init() {
        weak var me = self
        _memoryWarning = Notification.observe(Notification.MemoryWarning, block: { me?.didReceiveMemoryWarning($0) })
    }
    
    deinit {
        Notification.unobserve(_memoryWarning)
    }
    
    
    func play(audio: String, inRange range: IntervalType) {
        if let controller = _controllers[audio] {
            controller.play(range)
        } else {
            let bundle = NSBundle.mainBundle()
            let path = bundle.pathForResource(audio, ofType: "")
            let controller = AudioController(audioPath: audio)
        }
        
            selectedAudio = audio
            selectedTimeInterval = range
    }
    
    
    // MARK: Notifications
    private func didReceiveMemoryWarning(notif: NSNotification) {
        _controllers.removeAll(keepCapacity: true)
    }
    
    // MARK: AudioControllerDelegate
    func audioController(controller: AudioController, didReachBookmark bookmark: NSTimeInterval) {
        
    }
}
