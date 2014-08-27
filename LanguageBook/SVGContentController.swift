import Foundation

class SVGContentController: ContentController {
    private var _interactiveLayers: [CALayer] = []
    private var _selectedLayers: [CALayer] = []
    
    let svgContent: SVGContent
    
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(SVGContent svg: SVGContent) {
        self.svgContent = svg
        super.init(content: svg)
    }
    
    // TODO: Add parent folder information. Name alone will surely not load.
    override func loadView() {
        if svgContent.interactive {
            view = SVGKLayeredImageView(SVGKImage: svgContent.image)
        } else {
            view = SVGKFastImageView(SVGKImage: svgContent.image)
        }
        
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.backgroundColor = .whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if svgContent.interactive {
            loadLayerData()
        }
    }
    
    private func loadLayerData() {
        
    }
}

