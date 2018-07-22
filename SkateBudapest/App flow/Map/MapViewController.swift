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

// MARK: MKMapView
extension MapViewController {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation,
                                                 reuseIdentifier: Constant.calloutViewIdentifier)
        annotationView.canShowCallout = true

        if (annotation as? Waypoint)?.thumbnailImageUrl != nil {
            annotationView.leftCalloutAccessoryView = UIButton(frame: Constant.leftAccessoryViewSize)
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let thumbnailImageButton = view.leftCalloutAccessoryView as? UIButton,
            let url = (view.annotation as? Waypoint)?.thumbnailImageUrl,
            let imageData = NSData(contentsOf: url),
            let image = UIImage(data: imageData as Data) {
            thumbnailImageButton.setImage(image, for: .normal)
        }
    }
}

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func setMapViewDelegate() {
        mapView.delegate = self
    }
}