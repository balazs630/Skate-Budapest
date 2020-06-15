//
//  RoutingViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 10. 22..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import MapKit

class RoutingViewController: UIViewController {
    // MARK: Properties
    fileprivate var routingEmptyViewController: RoutingEmptyViewController?
    var destinationLocation: CLLocationCoordinate2D!

    // MARK: Outlets
    @IBOutlet weak var transitRouteButton: UIButton!
    @IBOutlet weak var drivingRouteButton: UIButton!
    @IBOutlet weak var walkingRouteButton: UIButton!

    @IBOutlet weak var transitActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var drivingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var walkingActivityIndicator: UIActivityIndicatorView!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        setupAppearance()
        setObserverForUIApplicationDidBecomeActive()
    }

    private func setupAppearance() {
        [transitRouteButton, drivingRouteButton, walkingRouteButton].forEach { button in
            button.backgroundColor = Theme.Color.primaryTurquoise
        }
    }

    private func setObserverForUIApplicationDidBecomeActive() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setupView),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }
}

// MARK: Actions
extension RoutingViewController {
    @IBAction func transitButtonTap(_ sender: Any) {
        openMaps(directionMode: MKLaunchOptionsDirectionsModeTransit)
    }

    @IBAction func drivingButtonTap(_ sender: Any) {
        openMaps(directionMode: MKLaunchOptionsDirectionsModeDriving)
    }

    @IBAction func walkingButtonTap(_ sender: Any) {
        openMaps(directionMode: MKLaunchOptionsDirectionsModeWalking)
    }
}

// MARK: UI Manipulation
extension RoutingViewController {
    @objc private func setupView() {
        if LocationService.shared.location != nil {
            routingEmptyViewController?.remove()
            requestETA(for: [.transit, .automobile, .walking])
        } else {
            routingEmptyViewController = RoutingEmptyViewController.instantiateViewController(from: .placeDetails)
            add(routingEmptyViewController!, to: view)
        }
    }

    private func setTransitTimeButtonTexts(for transportType: MKDirectionsTransportType, travelTime: TimeInterval) {
        switch transportType {
        case .transit:
            transitRouteButton.setTitle(travelTime.stringTime, for: .normal)
            transitActivityIndicator.isHidden = true
        case .automobile:
            drivingRouteButton.setTitle(travelTime.stringTime, for: .normal)
            drivingActivityIndicator.isHidden = true
        case .walking:
            let skateSpeed = 2.0
            walkingRouteButton.setTitle((travelTime / skateSpeed).stringTime, for: .normal)
            walkingActivityIndicator.isHidden = true
        default:
            debugPrint("Unknown transportType: \(transportType)")
        }
    }
}

// MARK: Maps Navigation
extension RoutingViewController {
    private func requestETA(for transportTypes: [MKDirectionsTransportType]) {
        let request = prepareTransitRequestInformations()

        transportTypes.forEach { transportType in
            request.transportType = transportType
            let directions = MKDirections(request: request)
            directions.calculateETA { [weak self] (etaResponse, error) -> Void in
                guard let `self` = self else { return }
                if let error = error {
                    ResultAlertDialog(title: Texts.PlaceDetails.directions.localized,
                                      message: error.localizedDescription).show()
                } else {
                    if let travelTime = etaResponse?.expectedTravelTime {
                        self.setTransitTimeButtonTexts(for: transportType, travelTime: travelTime)
                    }
                }
            }
        }
    }

    private func prepareTransitRequestInformations() -> MKDirections.Request {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: LocationService.shared.coordinates!))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation))
        request.requestsAlternateRoutes = false

        return request
    }

    private func openMaps(directionMode: String) {
        guard let currentLocation = LocationService.shared.coordinates else { return }
        let currentLocationMapItem = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation))
        currentLocationMapItem.name = Texts.PlaceDetails.start.localized

        let destinationLocationMapItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation))
        destinationLocationMapItem.name = Texts.PlaceDetails.destination.localized

        MKMapItem.openMaps(with: [currentLocationMapItem, destinationLocationMapItem],
                           launchOptions: [MKLaunchOptionsDirectionsModeKey: directionMode])
    }
}
