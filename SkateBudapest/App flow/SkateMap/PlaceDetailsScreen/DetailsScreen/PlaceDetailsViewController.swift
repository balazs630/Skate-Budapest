//
//  PlaceDetailsViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit
import CoreLocation

class PlaceDetailsViewController: UIViewController {
    // MARK: Properties
    weak var coordinator: SkateMapCoordinator?
    var place: PlaceDisplayItem!
    var imageViews: [UIImageView]?
    var imageOffset = IndexPath(row: 0, section: 0)

    // MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var locationTypeView: UIView!
    @IBOutlet private weak var locationTypeLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var descriptionTextViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet private weak var routingContainerView: UIView!
    @IBOutlet private weak var imageScrollView: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        addChildViewControllers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let xOffset = imageScrollView.frame.width * CGFloat(imageOffset.row)
        pageControl.currentPage = imageOffset.row
        imageScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: false)
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)

        guard parent == nil else { return }
        backToSkateMapScreen()
    }
}

// MARK: - Screen configuration
extension PlaceDetailsViewController {
    private func configureSelf() {
        configureNavigationBarTitleView()
        configureNavigationBarButtons()
        configureTexts()
        configureLocationTypeView()
        configureImageScrollView()
        configurePageControl()
        addAccessibilityIDs()
    }

    private func configureNavigationBarTitleView() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Theme.Color.navbarLightGrey
    }

    private func configureNavigationBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Theme.Icon.bandageIcon,
            style: .plain,
            target: self,
            action: #selector(toReportScreen)
        )
    }

    private func configureTexts() {
        titleLabel.text = place.name
        distanceLabel.text = destinationDistanceInKilometer()

        descriptionTextView.attributedText = {
            let attributedText = try? NSMutableAttributedString(
                htmlString: place.info,
                font: .systemFont(ofSize: 17))

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4

            attributedText?.addFullRangeAttributes([
                .paragraphStyle: paragraphStyle,
                .foregroundColor: Theme.Color.textDark
            ])

            return attributedText
        }()

        DispatchQueue.main.async {
            self.descriptionTextViewHeightConstraint.constant = self.descriptionTextView.textFitHeight
        }
    }

    private func destinationDistanceInKilometer() -> String {
        let destinationLocation = CLLocation(latitude: place.coordinate.latitude,
                                             longitude: place.coordinate.longitude)
        guard let distance = LocationService.shared.location?.distance(from: destinationLocation) else {
            return ""
        }

        return String(format: "%.1f km", distance / 1000)
    }

    private func addAccessibilityIDs() {
        titleLabel.accessibilityIdentifier = AccessibilityID.PlaceDetails.titleLabel
        locationTypeView.accessibilityIdentifier = AccessibilityID.PlaceDetails.categoryView
        locationTypeLabel.accessibilityIdentifier = AccessibilityID.PlaceDetails.categoryLabel
        descriptionTextView.accessibilityIdentifier = AccessibilityID.PlaceDetails.descriptionLabel
    }

    private func configureLocationTypeView() {
        locationTypeLabel.text = place.type.rawValue
        locationTypeView.backgroundColor = place.type.backgroundColor
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
        pageControl.numberOfPages = place.imageDatas.count
    }

    private func loadImageViews() -> [UIImageView] {
        let images = place.imageDatas
            .map { UIImage(data: $0 ?? Data()) }

        var imageViews = [UIImageView]()
        (0..<images.count).forEach { index in
            let imageView = UIImageView()
            imageView.image = images[index]
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(
                x: view.frame.width * CGFloat(index),
                y: 0,
                width: UIScreen.main.bounds.width,
                height: imageScrollView.frame.height
            )

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
        routingViewController.destinationLocation = place.coordinate
        add(routingViewController, to: routingContainerView)
    }
}

// MARK: Navigation
extension PlaceDetailsViewController {
    @objc private func toImageViewerScreen() {
        imageOffset.row = pageControl.currentPage
        coordinator?.toImageViewerScreen(from: self)
    }

    private func backToSkateMapScreen() {
        coordinator?.backToSkateMapScreen()
    }

    @objc private func toReportScreen() {
        coordinator?.toReportingScreen(place: place)
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
