//
//  LocationDetailsViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit
import CoreLocation

class LocationDetailsViewController: UIViewController {
    // MARK: Properties
    fileprivate var routingViewController: RoutingViewController?
    var waypoint: Waypoint!
    var imageViews: [UIImageView]?
    var imageOffset = IndexPath(row: 0, section: 0)

    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var locationTypeView: UIView!
    @IBOutlet weak var locationTypeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        setupChildViewControllers()
    }

    override func viewWillAppear(_ animated: Bool) {
        let xOffset = imageScrollView.frame.width * CGFloat(imageOffset.row)
        pageControl.currentPage = imageOffset.row
        imageScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: false)
    }
}

// MARK: - Setup view
extension LocationDetailsViewController {
    private func configureSelf() {
        configureNavigationBarTitleView()
        configureLabels()
        configureLocationTypeView()
        configureImageScrollView()
        configurePageControl()
    }

    private func setupChildViewControllers() {
        setupRoutingViewController()
    }

    private func setupRoutingViewController() {
        routingViewController = children
            .filter { $0.isKind(of: RoutingViewController.self) }
            .first as? RoutingViewController

        routingViewController?.destinationLocation = waypoint.coordinate
    }

    private func configureNavigationBarTitleView() {
        let image = getLocationIcon()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        navigationItem.titleView = imageView
    }

    private func getLocationIcon() -> UIImage {
        switch waypoint.type {
        case .skatepark:
            return Theme.Icon.skateparkIcon
        case .streetspot:
            return Theme.Icon.streetSpotIcon
        case .skateshop:
            return Theme.Icon.skateshopIcon
        }
    }

    private func configureLabels() {
        titleLabel.text = waypoint.name
        descriptionLabel.text = waypoint.info
        distanceLabel.text = destinationDistanceInKilometer()
    }

    private func destinationDistanceInKilometer() -> String {
        let destinationLocation = CLLocation(latitude: waypoint.coordinate.latitude,
                                             longitude: waypoint.coordinate.longitude)
        guard let distance = LocationManager.shared.location?.distance(from: destinationLocation) else {
            return ""
        }

        return String(format: "%.1f km", distance / 1000)
    }

    private func configureLocationTypeView() {
        locationTypeLabel.text = waypoint.type.rawValue
        locationTypeView.backgroundColor = getLocationColor()
    }

    private func getLocationColor() -> UIColor {
        switch waypoint.type {
        case .skatepark:
            return Theme.Color.skateparkColor
        case .streetspot:
            return Theme.Color.streetSpotColor
        case .skateshop:
            return Theme.Color.skateshopColor
        }
    }

    private func configureImageScrollView() {
        imageScrollView.delegate = self

        imageViews = loadImageViews()
        if let imageViews = imageViews {
            imageScrollView.addSubviews(imageViews)
            imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(imageViews.count)
        }

        let imageTap = UITapGestureRecognizer(target: self, action: #selector(navigateToImageViewerScreen))
        imageTap.cancelsTouchesInView = false
        imageScrollView.addGestureRecognizer(imageTap)
    }

    private func configurePageControl() {
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
        guard segue.identifier != nil else { return }

        switch segue.identifier {
        case SegueIdentifier.showImageViewer:
            guard let destVC = segue.destination as? ImageViewerViewController else { return }

            destVC.images = imageViews?.images()
            imageOffset.row = pageControl.currentPage
            destVC.imageOffset = imageOffset
            destVC.delegate = self
        default:
            debugPrint("Unexpected segue identifier was given in: \(#file), line: \(#line)")
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
