import Foundation

@objc class MediaSynchronizer: NSObject {
    let medias: [MediaController]
    
    private var syncPlayhead = false
    private var syncScope = false
    
    init(medias: [MediaController]) {
        self.medias = medias
        super.init()
        
        for media in medias {
            media.playheadDidChange = playheadDidChange(media)
            media.scopeDidChange = scopeDidChange(media)
        }
    }
    
    
    private func playheadDidChange(media: MediaController) {
        sync(&syncPlayhead) {
            for m in self.medias { m.playhead = media.playhead }
        }
    }
    
    private func scopeDidChange(media: MediaController) {
        sync(&syncScope) {
            for m in self.medias { m.scope = media.scope }
        }
    }
    
    private func sync(inout lock: Bool, action: () -> ()) {
        // TODO: Use a proper multi-threaded atomic lock?
        if lock { return }
        lock = true
        action()
        lock = false
    }
}
