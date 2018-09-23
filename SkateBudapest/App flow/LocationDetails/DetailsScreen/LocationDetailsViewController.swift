//
//  LocationDetailsViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailsViewController: UIViewController {
    // MARK: Properties
    var waypoint: Waypoint!
    var currentLocation: CLLocationCoordinate2D?
    var imageViews: [UIImageView]?
    var imageOffset = IndexPath(row: 0, section: 0)

    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var locationTypeView: UIView!
    @IBOutlet weak var locationTypeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var mapRoutingContainerView: UIView!
    @IBOutlet weak var transitionTypesStackView: UIStackView!
    @IBOutlet weak var transitRoutingButton: UIButton!
    @IBOutlet weak var carRoutingButton: UIButton!
    @IBOutlet weak var walkRoutingButton: UIButton!

    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    override func viewWillAppear(_ animated: Bool) {
        let xOffset = imageScrollView.frame.width * CGFloat(imageOffset.row)
        pageControl.currentPage = imageOffset.row
        imageScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        requestETA(for: [.transit, .automobile, .walking])
    }
}

// MARK: - UI manipulation
extension LocationDetailsViewController {
    private func configureSelf() {
        configureNavigationBarTitleView()
        configureLabels()
        configureLocationTypeView()
        configureImageScrollView()
        configurePageControl()
        configureMapRoutingViews()
    }

    private func configureNavigationBarTitleView() {
        let image = getLocationIcon()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
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
    }

    private func configureLocationTypeView() {
        locationTypeLabel.text = waypoint.type.rawValue
        locationTypeView.layer.cornerRadius = 10
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

    private func configureMapRoutingViews() {
        mapRoutingContainerView.layer.cornerRadius = 10
        transitRoutingButton.layer.cornerRadius = 10
        carRoutingButton.layer.cornerRadius = 10
        walkRoutingButton.layer.cornerRadius = 10
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

            destVC.images = imageViews?.images()
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

// MARK: Maps Navigation
extension LocationDetailsViewController {
    private func requestETA(for transportTypes: [MKDirectionsTransportType]) {
        let request = prepareTransitRequestInformations()

        transportTypes.forEach { transportType in
            request.transportType = transportType
            let directions = MKDirections(request: request)
            directions.calculateETA { (etaResponse, error) -> Void in
                if let error = error {
                    debugPrint("Not Available: \(error)")
                } else {
                    if let travelTime = etaResponse?.expectedTravelTime {
                        self.setTransitTimeButtonTexts(for: transportType, travelTime: travelTime)
                    }
                }
            }
        }
    }

    private func prepareTransitRequestInformations() -> MKDirections.Request {
        let sourceItem = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation!,
                                                          addressDictionary: nil))

        let destinationItem = MKMapItem(placemark: MKPlacemark(coordinate: waypoint.coordinate,
                                                               addressDictionary: nil))

        let request = MKDirections.Request()
        request.source = sourceItem
        request.destination = destinationItem
        request.requestsAlternateRoutes = false

        return request
    }

    private func setTransitTimeButtonTexts(for transportType: MKDirectionsTransportType, travelTime: TimeInterval) {
        switch transportType {
        case .transit:
            self.transitRoutingButton.setTitle(travelTime.stringTime, for: .normal)
            hideActivityIndicatorWith(tag: 1)
        case .automobile:
            self.carRoutingButton.setTitle(travelTime.stringTime, for: .normal)
            hideActivityIndicatorWith(tag: 2)
        case .walking:
            self.walkRoutingButton.setTitle(travelTime.stringTime, for: .normal)
            hideActivityIndicatorWith(tag: 3)
        default:
            debugPrint("Unknown transportType: \(transportType)")
        }
    }

    private func hideActivityIndicatorWith(tag: Int) {
        _ = transitionTypesStackView.subviews
            .flatMap({ $0.subviews })
            .filter { $0.isKind(of: UIActivityIndicatorView.self) }
            .filter { $0.tag == tag }
            .compactMap({ $0.isHidden = true })
    }
}
