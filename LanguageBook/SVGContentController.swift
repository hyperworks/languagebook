import Foundation

class SVGContentController: ContentController {
    let svgContent: SVGContent
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(SVGContent svg: SVGContent) {
        self.svgContent = svg
        super.init(content: svg)
    }
    
    // TODO: Add parent folder information. Name alone will surely not load.
    override func loadView() {
        let image = SVGKImage(contentsOfFile: svgContent.path)
        
        if svgContent.interactive {
            view = SVGKLayeredImageView(SVGKImage: image)
        } else {
            view = SVGKFastImageView(SVGKImage: image)
        }
    }
}

