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

    // MARK: Outlets
    @IBOutlet weak var publicTransportRoutingButton: UIButton!
    @IBOutlet weak var carRoutingButton: UIButton!
    @IBOutlet weak var walkRoutingButton: UIButton!

    @IBOutlet weak var publicTransportActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var carActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var walkActivityIndicator: UIActivityIndicatorView!

    // MARK: View lifecycle
    override func viewDidAppear(_ animated: Bool) {
        requestETA(for: [.transit, .automobile, .walking])
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
        let sourceItem = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation,
                                                          addressDictionary: nil))

        let destinationItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation,
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
            publicTransportRoutingButton.setTitle(travelTime.stringTime, for: .normal)
            publicTransportActivityIndicator.isHidden = true
        case .automobile:
            carRoutingButton.setTitle(travelTime.stringTime, for: .normal)
            carActivityIndicator.isHidden = true
        case .walking:
            walkRoutingButton.setTitle(travelTime.stringTime, for: .normal)
            walkActivityIndicator.isHidden = true
        default:
            debugPrint("Unknown transportType: \(transportType)")
        }
    }
}
