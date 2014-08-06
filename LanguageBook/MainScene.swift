import SpriteKit
import AVFoundation

class MainScene: NavigableScene, MarkedStringNodeDelegate {
    let speech = AVSpeechSynthesizer()
    let titleLabel = SKLabelNode(fontNamed: "Thonburi")
    let storyTextNode = MarkedStringNode()

//    override var nextSceneType: Scene.Type? { return SecondScene.self }

    init() { }

    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        
        backgroundColor = .grayColor()
        nextButton.color = .grayColor()
        previousButton.color = .grayColor()
        previousButton.hidden = true
        
        titleLabel.text = "(ch)"
        titleLabel.position = CGPoint(x: 512, y: 576)
        addChild(titleLabel)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .Center
        paragraph.lineBreakMode = .ByClipping
        
        let loader = MarkedStringLoader(setName: "01", attributes: [
            NSFontAttributeName: UIFont(name: "Thonburi", size: 24.0),
            NSParagraphStyleAttributeName: paragraph,
            NSForegroundColorAttributeName: SKColor.whiteColor(),
            ])
        let markedString = loader.load()
        
        storyTextNode.markedString = markedString
        storyTextNode.position = CGPoint(x: 300, y: 300)
        storyTextNode.size = CGSize(width: 500, height: 500)
        storyTextNode.delegate = self
        addChild(storyTextNode)
        addChild(DebugNode(sprite: storyTextNode))
    }
    
    
    // MARK: MarkedStringNodeDelegate
    func markedStringNode(node: MarkedStringNode, didTapPortion portion: TextPortion) {
        let str = node.markedString!.script.string!
        let span = portion.wordSpan
        let range = Range(start: span.from, end: span.to)
        let word = str.substringWithRange(range)
        titleLabel.text = word

        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "th-TH")
        utterance.volume = 1.0

        speech.stopSpeakingAtBoundary(.Word)
        speech.speakUtterance(utterance)
    }
}
