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
    var currentLocation: CLLocationCoordinate2D!
    var destinationLocation: CLLocationCoordinate2D!

    var currentLocationMapItem: MKMapItem {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation))
        mapItem.name = "Source"

        return mapItem
    }

    var destinationLocationMapItem: MKMapItem {
        let mapItem =  MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation))
        mapItem.name = "Destination"

        return mapItem
    }

    // MARK: Outlets
    @IBOutlet weak var transitRouteButton: UIButton!
    @IBOutlet weak var drivingRouteButton: UIButton!
    @IBOutlet weak var walkingRouteButton: UIButton!

    @IBOutlet weak var transitActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var drivingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var walkingActivityIndicator: UIActivityIndicatorView!

    // MARK: View lifecycle
    override func viewDidAppear(_ animated: Bool) {
        requestETA(for: [.transit, .automobile, .walking])
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
        request.source = currentLocationMapItem
        request.destination = destinationLocationMapItem
        request.requestsAlternateRoutes = false

        return request
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

    private func openMaps(directionMode: String) {
        MKMapItem.openMaps(with: [currentLocationMapItem, destinationLocationMapItem],
                           launchOptions: [MKLaunchOptionsDirectionsModeKey: directionMode])
    }
}
