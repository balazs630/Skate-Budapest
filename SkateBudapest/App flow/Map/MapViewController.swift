//
//  MapViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setMapViewDelegate()
        loadMapWaypointsFrom(url: URL(string: Constant.dataSourceGPXUrl)!)
    }

    // MARK: Setup mapView
    private func loadMapWaypointsFrom(url: URL) {
        clearWaypoints()
        GPXParser.parse(url: url) { gpx in
            if let waypoints = gpx?.waypoints {
                self.add(waypoints: waypoints)
            }
        }
    }

    private func clearWaypoints() {
        mapView.removeAnnotations(mapView.annotations)
    }

    private func add(waypoints: [Waypoint]) {
        mapView.addAnnotations(waypoints)
        mapView.showAnnotations(waypoints, animated: true)
    }
}

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func setMapViewDelegate() {
        mapView.delegate = self
    }
}
