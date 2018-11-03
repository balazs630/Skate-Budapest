//
//  RoutingViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 10. 22..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit
import MapKit

class RoutingViewController: UIViewController {
    // MARK: Properties
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
        setObserverForUIApplicationDidBecomeActive()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
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

    @IBAction func enableLocationTap(_ sender: Any) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsUrl)
    }
}

// MARK: UI Manipulation
extension RoutingViewController {
    @objc private func setupView() {
        if LocationManager.shared.location != nil {
            presentEmptyView(false)
            requestETA(for: [.transit, .automobile, .walking])
        } else {
            presentEmptyView(true)
        }
    }

    private func presentEmptyView(_ state: Bool) {
        let emptyViewTag = 1
        view.subviews
            .filter { $0.tag == emptyViewTag }
            .forEach { $0.isHidden = !state }
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
            walkingRouteButton.setTitle(travelTime.stringTime, for: .normal)
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
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: LocationManager.shared.coordinates!))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation))
        request.requestsAlternateRoutes = false

        return request
    }

    private func openMaps(directionMode: String) {
        guard let currentLocation = LocationManager.shared.coordinates else { return }
        let currentLocationMapItem = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation))
        currentLocationMapItem.name = "Source"

        let destinationLocationMapItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation))
        destinationLocationMapItem.name = "Destination"

        MKMapItem.openMaps(with: [currentLocationMapItem, destinationLocationMapItem],
                           launchOptions: [MKLaunchOptionsDirectionsModeKey: directionMode])
    }
}
