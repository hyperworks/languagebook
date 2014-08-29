import UIKit
import QuartzCore

class SVGContentViewController: ContentViewController {
    private var _interactiveLayers: [CALayer] = []
    private var _activeLayers: [CALayer] = []
    
    let svgContent: SVGContent
    
    override var playhead: AudioTime {
        didSet { didChangePlayhead(playhead) }
    }
    
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(SVGContent svg: SVGContent) {
        self.svgContent = svg
        super.init(content: svg)
    }
    
    // TODO: Add parent folder information. Name alone will surely not load.
    override func loadView() {
        let klass: SVGKImageView.Type = svgContent.interactive ? SVGKLayeredImageView.self : SVGKFastImageView.self
        
        let v = klass(SVGKImage: svgContent.image)
        v.setTranslatesAutoresizingMaskIntoConstraints(false)
        v.backgroundColor = .clearColor()
        v.opaque = false
        
        if svgContent.interactive {
            let gesture = UITapGestureRecognizer(target: self, action: "didTapImage:")
            v.userInteractionEnabled = true
            v.addGestureRecognizer(gesture)
        }
        
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if svgContent.interactive {
            setupLayerInteraction()
        }
    }
    
    private func setupLayerInteraction() {
        let loader = LayerDataLoader(image: svgContent.image)
        _interactiveLayers = loader.load()
        _activeLayers = []
    }
    
    
    func didTapImage(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(view)
        
        let hitLayer = svgContent.image.CALayerTree.hitTest(point)
        if hitLayer == nil { return }
        
        if let data = resolveLayerData(hitLayer) {
            if let scope = data.scope {
                self.scope = scope
            }
        }
    }
    
    private func resolveLayerData(layer: CALayer) -> LayerData? {
        if let d = LayerData.readFrom(layer) {
            return d
        }
        
        return layer.superlayer != nil ? resolveLayerData(layer.superlayer!) : nil
    }
    
    
    private func didChangePlayhead(playhead: AudioTime) {
        let predicate = layerShouldBeActiveDuringPlayhead(playhead)
        
        let stillActive = _activeLayers.filter(predicate)
        let activating = _interactiveLayers.filter(predicate).filter({ find(stillActive, $0) == nil })
        // TODO: let deactivating = _activeLayers.filter({ !predicate(layer: $0) })

        // TODO: for layer in deactivating { deactivateLayer(layer) }
        for layer in activating { activateLayer(layer) }
        _activeLayers = stillActive + activating
    }

    private func layerShouldBeActiveDuringPlayhead(playhead: AudioTime) (layer: CALayer) -> Bool {
        if let data = LayerData.readFrom(layer) {
            if let scope = data.scope {
                return scope ~= playhead
            }
        }

        return false
    }

    private func activateLayer(layer: CALayer) {
        let data: LayerData! = LayerData.readFrom(layer)
        if data == nil { return }

        let anim: String! = data.animation
        if anim == nil { return }

        // TODO: More layer animation.
        switch anim {
        case "bounce":
            let anim = CABasicAnimation(keyPath: "position")
            anim.fromValue = NSValue(CGPoint: layer.position)
            anim.toValue = NSValue(CGPoint: CGPoint(x: layer.position.x, y: layer.position.y - 20))
            anim.autoreverses = true
            
            if let scope = data.scope {
                anim.duration = (scope.end - scope.start) * 0.5
            } else {
                anim.duration = 0.5
            }

            layer.addAnimation(anim, forKey: "position")

        default:
            dump(anim, name: "unknown animation")
        }
    }
}

