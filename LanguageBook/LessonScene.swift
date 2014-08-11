import SpriteKit
import AVFoundation

class LessonScene: NavigableScene, MarkedStringNodeDelegate, AudioControllerDelegate {
    private var _audio: AudioController? = nil
    private let _speech = AVSpeechSynthesizer()
    
    let titleLabel = SKLabelNode(fontNamed: "Thonburi")
    let playButton = Button(text: "PLAY")
    let storyTextNode = MarkedStringNode()
    
    var setName: String { fatalError("must be overridden in child class.") }
    
    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        backgroundColor = .grayColor()
        
        playButton.color = .greenColor()
        playButton.position = CGPoint(x: 512, y: 192)
        playButton.didTapButton = didTapPlay
        addChild(playButton)
        
        titleLabel.text = "(ch)"
        titleLabel.position = CGPoint(x: 512, y: 100)
        addChild(titleLabel)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .Center
        paragraph.lineBreakMode = .ByClipping
        
        let loader = MarkedStringLoader(setName: setName, attributes: [
            NSFontAttributeName: UIFont(name: "Thonburi", size: 24.0),
            NSParagraphStyleAttributeName: paragraph,
            NSForegroundColorAttributeName: SKColor.whiteColor(),
            ])
        let markedString = loader.load()
        
        storyTextNode.markedString = markedString
        storyTextNode.position = CGPoint(x: 512, y: 480)
        storyTextNode.size = CGSize(width: 768, height: 384)
        storyTextNode.delegate = self
        storyTextNode.zPosition = previousButton.zPosition + 1.0
        addChild(storyTextNode)
        addChild(DebugNode(sprite: storyTextNode))
    }
    
    
    func didTapPlay() {
        let ms = storyTextNode.markedString!
        if let a = _audio {
            a.stop()
        }
        
        _audio?.stop()
        _audio = AudioController(audioPath: ms.audioPath)
        _audio?.delegate = self
        for portion in ms.portions {
            _audio?.addBookmark(portion.timeSpan.start)
        }

        _audio?.playFromBeginning()
        dump("playing from beginning")
    }
    
    
    // MARK: MarkedStringNodeDelegate
    func markedStringNode(node: MarkedStringNode, didTapPortion portion: TextPortion) {
        let ms = node.markedString!
        let str = ms.script.string!
        
        let wordSpan = portion.wordSpan
        let word = portion.wordInString(str)
        titleLabel.text = word

        _audio?.stop()
        _audio = AudioController(audioPath: ms.audioPath)
        _audio?.delegate = self

        let timeSpan = portion.timeSpan
        _audio?.play(startAt: portion.timeSpan.start, playUntil: portion.timeSpan.end)
        dump(timeSpan, name: "playing audio portion.")
    }
    
    
    // MARK: AudioControllerDelegate
    func audioController(controller: AudioController, didReachBookmark bookmark: NSTimeInterval) {
        let ms = storyTextNode.markedString!
        for portion in ms.portions {
            if portion.timeSpan.start == bookmark {
                ms.removeAllHighlights()
                ms.highlightPortion(portion)
                storyTextNode.invalidate()
                titleLabel.text = portion.wordInString(ms.script.string!)
                return
            }
        }
    }
}
