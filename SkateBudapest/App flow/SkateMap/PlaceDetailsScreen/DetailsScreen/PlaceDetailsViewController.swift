//
//  PlaceDetailsViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit
import CoreLocation

class PlaceDetailsViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var coordinator: SkateMapCoordinator?
    var waypoint: PlaceDisplayItem!
    var imageViews: [UIImageView]?
    var imageOffset = IndexPath(row: 0, section: 0)

    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationTypeView: UIView!
    @IBOutlet weak var locationTypeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var routingContainerView: UIView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        addChildViewControllers()
    }

    override func viewWillAppear(_ animated: Bool) {
        let xOffset = imageScrollView.frame.width * CGFloat(imageOffset.row)
        pageControl.currentPage = imageOffset.row
        imageScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: false)
    }

    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            backToSkateMapScreen()
        }
    }
}

// MARK: - Screen configuration
extension PlaceDetailsViewController {
    private func configureSelf() {
        configureNavigationBarTitleView()
        configureLabels()
        configureLocationTypeView()
        configureImageScrollView()
        configurePageControl()
    }

    private func configureNavigationBarTitleView() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Theme.Color.navbarLightGrey
    }

    private func configureLabels() {
        titleLabel.text = waypoint.name
        descriptionLabel.text = waypoint.info
        descriptionLabel.textColor = Theme.Color.textDark
        distanceLabel.text = destinationDistanceInKilometer()
    }

    private func destinationDistanceInKilometer() -> String {
        let destinationLocation = CLLocation(latitude: waypoint.coordinate.latitude,
                                             longitude: waypoint.coordinate.longitude)
        guard let distance = LocationService.shared.location?.distance(from: destinationLocation) else {
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
            return Theme.Color.skatepark
        case .streetspot:
            return Theme.Color.streetSpot
        case .skateshop:
            return Theme.Color.skateshop
        }
    }

    private func configureImageScrollView() {
        imageScrollView.delegate = self

        imageViews = loadImageViews()
        if let imageViews = imageViews {
            imageScrollView.addSubviews(imageViews)
            imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(imageViews.count)
        }

        let imageTap = UITapGestureRecognizer(target: self, action: #selector(toImageViewerScreen))
        imageTap.cancelsTouchesInView = false
        imageScrollView.addGestureRecognizer(imageTap)
    }

    private func configurePageControl() {
        pageControl.numberOfPages = waypoint.imageDatas.count
    }

    private func loadImageViews() -> [UIImageView] {
        let images = waypoint.imageDatas
            .map { UIImage(data: $0 ?? Data()) }

        var imageViews = [UIImageView]()
        (0..<images.count).forEach { index in
            let imageView = UIImageView()
            imageView.image = images[index]
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: view.frame.width * CGFloat(index),
                                     y: 0,
                                     width: UIScreen.main.bounds.width,
                                     height: imageScrollView.frame.height)

            imageViews.append(imageView)
        }

        return imageViews
    }
}

// MARK: - Setup view
extension PlaceDetailsViewController {
    private func addChildViewControllers() {
        addRoutingViewController()
    }

    private func addRoutingViewController() {
        let routingViewController = RoutingViewController.instantiateViewController(from: .placeDetails)
        routingViewController.destinationLocation = waypoint.coordinate
        add(routingViewController, to: routingContainerView)
    }
}

// MARK: Navigation
extension PlaceDetailsViewController {
    @objc private func toImageViewerScreen() {
        imageOffset.row = pageControl.currentPage
        coordinator?.toImageViewerScreen(using: self)
    }

    private func backToSkateMapScreen() {
        coordinator?.backToSkateMapScreen()
    }
}

// MARK: UIScrollViewDelegate methods
extension PlaceDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
    }
}

// MARK: ImageViewerViewControllerDelegate methods
extension PlaceDetailsViewController: ImageViewerViewControllerDelegate {
    func updateImageOffset(indexPath: IndexPath) {
        imageOffset = indexPath
    }
}
