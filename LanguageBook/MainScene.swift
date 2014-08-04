import SpriteKit
import AVFoundation

class MainScene: NavigableScene, MarkedTextNodeDelegate {
    let speech: AVSpeechSynthesizer = AVSpeechSynthesizer()
    let titleLabel: SKLabelNode = SKLabelNode(fontNamed: "Thonburi")
    let storyTextNode: MarkedTextNode = MarkedTextNode(markedText: Dummy.scenarioOne())
    
    override var nextSceneType: Scene.Type? { return SecondScene.self }

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

        storyTextNode.position = CGPoint(x: 300, y: 400)
        storyTextNode.size = CGSize(width: 300, height: 300)
        storyTextNode.delegate = self
        addChild(storyTextNode)
        addChild(DebugNode(sprite: storyTextNode))
    }
    
    
    // MARK: MarkedTextNodeDelegate
    func markedTextNode(node: MarkedTextNode, didTapPortion portion: TextPortion) {
        titleLabel.text = portion.word
        
        for object in AVSpeechSynthesisVoice.speechVoices() {
            let voice = object as AVSpeechSynthesisVoice
            NSLog("available voice: %@", voice.language)
        }
        
        let utterance = AVSpeechUtterance(string: portion.word)
        utterance.voice = AVSpeechSynthesisVoice(language: "th-TH")
        utterance.volume = 1.0
        
        speech.stopSpeakingAtBoundary(.Word)
        speech.speakUtterance(utterance)
    }
}
