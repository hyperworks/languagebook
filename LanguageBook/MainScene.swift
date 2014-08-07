import SpriteKit
import AVFoundation

class MainScene: NavigableScene, MarkedStringNodeDelegate, AVAudioPlayerDelegate {
    private var _audio: AudioController? = nil
    
    let speech = AVSpeechSynthesizer()
    let titleLabel = SKLabelNode(fontNamed: "Thonburi")
    let playButton = Button(text: "PLAY")
    let storyTextNode = MarkedStringNode()

//    override var nextSceneType: Scene.Type? { return SecondScene.self }

    init() { }

    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        
        backgroundColor = .grayColor()
        nextButton.color = .grayColor()
        previousButton.color = .grayColor()
        previousButton.hidden = true
        
        var p = nextButton.position
        p.y += 150.0
        
        playButton.color = .greenColor()
        playButton.position = p
        playButton.onPress = didTapPlay
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
        _audio?.playFromBeginning()
    }
    
    
    // MARK: MarkedStringNodeDelegate
    func markedStringNode(node: MarkedStringNode, didTapPortion portion: TextPortion) {
        let ms = node.markedString!
        let str = ms.script.string!
        
        let wordSpan = portion.wordSpan
        let range = Range(start: wordSpan.from, end: wordSpan.to)
        let word = str.substringWithRange(range)
        titleLabel.text = word

        let timeSpan = portion.timeSpan
        _audio?.stop()
        _audio = AudioController(audioPath: ms.audioPath)
        _audio?.play(startAt: Double(timeSpan.from), playUntil: Double(timeSpan.to))
        
        dump(timeSpan, name: "playing a span")
    }
}
