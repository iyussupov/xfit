//
//  ZoomablePhotoView.swift
//  ImageSlideshow
//
//  Created by Petr Zvoníček on 30.07.15.
//

import UIKit

public class ImageSlideshowItem: UIScrollView, UIScrollViewDelegate {
    
    var imageView = UIImageView()
    let zoomEnabled: Bool
    
    init(image: InputSource, zoomEnabled: Bool) {
        self.zoomEnabled = zoomEnabled
        
        super.init(frame: CGRectNull)
        
        image.setToImageView(imageView)
        
        imageView.clipsToBounds = true
        imageView.userInteractionEnabled = true
        
        setPictoCenter()
        
        // scroll view configuration
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.addSubview(imageView)
        self.minimumZoomScale = 1.0
        self.maximumZoomScale = calculateMaximumScale()
        
        // tap gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: "tapZoom")
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isZoomed() -> Bool {
        return self.zoomScale != self.minimumZoomScale
    }
    
    func zoomOut() {
        self.setZoomScale(minimumZoomScale, animated: false)
    }
    
    func tapZoom() {
        if isZoomed() {
            self.setZoomScale(minimumZoomScale, animated: true)
        } else {
            self.setZoomScale(maximumZoomScale, animated: true)
        }
    }
    
    private func screenSize() -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    private func calculatePictureFrame() {
        let boundsSize: CGSize = self.bounds.size
        var frameToCenter: CGRect = imageView.frame
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        imageView.frame = frameToCenter
    }
    
    private func calculatePictureSize() -> CGSize {
        if let image = imageView.image {
            let picSize = image.size
            let picRatio = picSize.width / picSize.height
            let screenRatio = screenSize().width / screenSize().height
            
            if (picRatio > screenRatio){
                return CGSize(width: screenSize().width, height: screenSize().width / picSize.width * picSize.height)
            } else {
                return CGSize(width: screenSize().height / picSize.height * picSize.width, height: screenSize().height)
            }
        } else {
            return CGSize(width: screenSize().width, height: screenSize().height)
        }
    }
    
    private func calculateMaximumScale() -> CGFloat {
        // maximum scale is fixed to 2.0 for now. This may be overriden to perform a more sophisticated computation
        return 2.0
    }
    
    private func setPictoCenter(){
        var intendHorizon = (screenSize().width - imageView.frame.width ) / 2
        var intendVertical = (screenSize().height - imageView.frame.height ) / 2
        intendHorizon = intendHorizon > 0 ? intendHorizon : 0
        intendVertical = intendVertical > 0 ? intendVertical : 0
        contentInset = UIEdgeInsets(top: intendVertical, left: intendHorizon, bottom: intendVertical, right: intendHorizon)
    }
    
    private func isFullScreen() -> Bool{
        if (imageView.frame.width >= screenSize().width && imageView.frame.height >= screenSize().height){
            return true
        } else {
            return false
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if (!zoomEnabled) {
            imageView.frame.size = frame.size;
        } else if (!isZoomed()) {
            imageView.frame.size = calculatePictureSize()
            setPictoCenter()
        }
        
        if (self.isFullScreen()) {
            self.clearContentInsets()
        } else {
            setPictoCenter()
        }
        
        self.maximumZoomScale = calculateMaximumScale()
    }
    
    func clearContentInsets(){
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: UIScrollViewDelegate
    
    public func scrollViewDidZoom(scrollView: UIScrollView) {
        setPictoCenter()
    }
    
    public func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.zoomEnabled ? imageView : nil;
    }
    
}