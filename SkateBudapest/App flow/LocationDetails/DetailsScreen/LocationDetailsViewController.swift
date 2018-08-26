//
//  LocationDetailsViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {
    // MARK: Properties
    var waypoint: Waypoint!
    var imageViews: [UIImageView]!
    var imageOffset = IndexPath(row: 0, section: 0)

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

    override func viewWillAppear(_ animated: Bool) {
        let xOffset = imageScrollView.frame.width * CGFloat(imageOffset.row)
        pageControl.currentPage = imageOffset.row
        imageScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: false)
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
        imageScrollView.delegate = self

        imageViews = loadImageViews()
        imageScrollView.addSubviews(imageViews)
        imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(imageViews.count)

        let imageTap = UITapGestureRecognizer(target: self, action: #selector(navigateToImageViewerScreen))
        imageTap.cancelsTouchesInView = false
        imageScrollView.addGestureRecognizer(imageTap)
    }

    private func setupPageControl() {
        pageControl.numberOfPages = waypoint.displayImageUrls.count
    }

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

// MARK: Navigation
extension LocationDetailsViewController {
    @objc private func navigateToImageViewerScreen() {
        performSegue(withIdentifier: SegueIdentifier.showImageViewer, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showImageViewer {
            guard let destVC = segue.destination as? ImageViewerViewController else { return }

            destVC.images = imageViews.images()
            imageOffset.row = pageControl.currentPage
            destVC.imageOffset = imageOffset
            destVC.delegate = self
        }
    }
}

// MARK: UIScrollViewDelegate methods
extension LocationDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
    }
}

// MARK: ImageViewerViewControllerDelegate methods
extension LocationDetailsViewController: ImageViewerViewControllerDelegate {
    func updateImageOffset(indexPath: IndexPath) {
        imageOffset = indexPath
    }
}
