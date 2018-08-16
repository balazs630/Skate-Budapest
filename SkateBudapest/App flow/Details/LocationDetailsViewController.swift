//
//  LocationDetailsViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {
    // Properties
    var waypoint: Waypoint!
    var selectedImage: UIImageView!

    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - UI manipulation
extension LocationDetailsViewController {
    private func setupView() {
        self.title = waypoint.name
        setupLabels()
        setupImageScrollView()
        setupPageControl()
    }

    private func setupLabels() {
        titleLabel.text = waypoint.name
        descriptionLabel.text = waypoint.info
    }

    private func setupImageScrollView() {
        let imageViews = loadImageViews()

        imageScrollView.delegate = self
        imageScrollView.addSubviews(imageViews)
        imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(imageViews.count)

        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImageInFullscreenTap))
        imageTap.cancelsTouchesInView = false
        imageScrollView.addGestureRecognizer(imageTap)
    }

    private func setupPageControl() {
        pageControl.numberOfPages = imageScrollView.subviews.count
    }
}

// TODO: loadImageViews to extensions?
extension LocationDetailsViewController {
    private func loadImageViews() -> [UIImageView] {
        let images = waypoint.displayImageUrls.imagesFromURLs()
        var imageViews = [UIImageView]()
        (0..<images.count).forEach { index in
            let imageView = UIImageView()
            imageView.image = images[index]
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: view.frame.width * CGFloat(index),
                                     y: 0,
                                     width: imageScrollView.frame.width,
                                     height: imageScrollView.frame.height)

            imageViews.append(imageView)
        }

        return imageViews
    }
}

// TODO: Refactor long method..
// MARK: Gesture recognisers
extension LocationDetailsViewController {
    @objc func openImageInFullscreenTap(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view?.subviews[pageControl.currentPage] as? UIImageView else { return }
        selectedImage = UIImageView(image: imageView.image)
        selectedImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        selectedImage.contentMode = .scaleAspectFit

        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.frame = UIScreen.main.bounds
        scrollView.backgroundColor = .black
        scrollView.contentMode = .scaleAspectFit

        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImageTap))
        dismissTap.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(dismissTap)

        scrollView.addSubview(selectedImage)
        view.addSubview(scrollView)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }

    @objc func dismissFullscreenImageTap(_ sender: UITapGestureRecognizer) {
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}

// MARK: UIScrollViewDelegate methods
extension LocationDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return selectedImage
    }
}
