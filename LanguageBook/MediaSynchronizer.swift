import Foundation

@objc class MediaSynchronizer: NSObject {
    let medias: [MediaController]
    
    private var syncPlayhead = false
    private var syncScope = false
    
    init(medias: [MediaController]) {
        self.medias = medias
        super.init()
        
        for m in medias {
            m.playheadDidChange = playheadDidChange(m)
            m.scopeDidChange = scopeDidChange(m)
        }
    }
    
    
    private func playheadDidChange(media: MediaController) {
        if syncPlayhead { return }
        syncPlayhead = true
        for m in self.medias { m.playhead = media.playhead }
        syncPlayhead = false
    }
    
    private func scopeDidChange(media: MediaController) {
        if syncScope { return }
        syncScope = true
        for m in self.medias { m.scope = media.scope }
        syncScope = false
    }
    
    private func sync(inout lock: Bool, action: () -> ()) {
        // TODO: Use a proper multi-threaded atomic lock?
        if lock { return }
        lock = true
        action()
        lock = false
    }
}
