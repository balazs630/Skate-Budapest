//
//  ImagePreviewFullViewCell.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 19..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class ImagePreviewFullViewCell: UICollectionViewCell {
    // MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: View lifecycle
    override func awakeFromNib() {
        scrollView.delegate = self
        addDoubleTapGestureRecogniser()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = self.bounds
        imageView.frame = self.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.setZoomScale(1, animated: true)
    }

    // MARK: Render cell
    public func display(image: UIImage) {
        imageView.image = image
    }
}

// MARK: Gesture recognisers
extension ImagePreviewFullViewCell {
    private func addDoubleTapGestureRecogniser() {
        let doubleTapGest = UITapGestureRecognizer(target: self,
                                                   action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGest)
    }

    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        let maximumZoomScaleRect = zoomRectFor(scale: scrollView.maximumZoomScale,
                                               center: recognizer.location(in: recognizer.view))
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: maximumZoomScaleRect, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }

    private func zoomRectFor(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width / scale

        let newCenter = imageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)

        return zoomRect
    }
}

// MARK: UIScrollViewDelegate methods
extension ImagePreviewFullViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
