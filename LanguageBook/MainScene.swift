import SpriteKit
import AVFoundation

class MainScene: NavigableScene, MarkedStringNodeDelegate, AVAudioPlayerDelegate, AudioControllerDelegate {
    private var _audio: AudioController? = nil
    
    let speech = AVSpeechSynthesizer()
    let titleLabel = SKLabelNode(fontNamed: "Thonburi")
    let playButton = Button(text: "PLAY")
    let storyTextNode = MarkedStringNode()

    override var nextSceneType: Scene.Type? { return SecondScene.self }

    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        
        backgroundColor = .grayColor()
        nextButton.color = .grayColor()
        previousButton.color = .grayColor()
        previousButton.hidden = true
        
        playButton.color = .greenColor()
        playButton.position = CGPoint(x: nextButton.position.x, y: nextButton.position.y + 150.0)
        playButton.didTapButton = didTapPlay
        addChild(playButton)
        
        titleLabel.text = "(ch)"
        titleLabel.position = CGPoint(x: 512, y: 100)
        addChild(titleLabel)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .Center
        paragraph.lineBreakMode = .ByClipping
        
        let markedString = MarkedStringLoader(setName: "01", attributes: [
            NSFontAttributeName: UIFont(name: "Thonburi", size: 24.0),
            NSParagraphStyleAttributeName: paragraph,
            NSForegroundColorAttributeName: SKColor.whiteColor(),
            ]).load()
        
        storyTextNode.markedString = markedString
        storyTextNode.position = CGPoint(x: 400, y: 400)
        storyTextNode.size = CGSize(width: 700, height: 500)
        storyTextNode.delegate = self
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
        
        dump(timeSpan, name: "playing portion of audio.")
    }


    // MARK: AudioControllerDelegate
    func audioController(controller: AudioController, didReachBookmark bookmark: NSTimeInterval) {
        dump(bookmark, name: "reached bookmark")

        let ms = storyTextNode.markedString!
        for portion in ms.portions {
            if portion.timeSpan.start == bookmark {
                ms.removeAllHighlights()
                ms.highlightPortion(portion)
                storyTextNode.invalidate()
                return
            }
        }
    }
}
