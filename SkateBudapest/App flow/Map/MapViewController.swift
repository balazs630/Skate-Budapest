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

    private func getAnnotationImage(for locationType: LocationType) -> UIImage {
        switch locationType {
        case .skatepark:
            return UIImage(named: Theme.Icons.skateparkPin)!
        case .skateshop:
            return UIImage(named: Theme.Icons.skateshopPin)!
        case .streetspot:
            return UIImage(named: Theme.Icons.streetSpotPin)!
        }
    }
}

// MARK: Navigation
extension MapViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let annotationView = sender as? MKAnnotationView
        guard let waypoint = annotationView?.annotation as? Waypoint else { return }

        if segue.identifier == SegueIdentifier.showLocationPinDetails {
            guard let destVC = segue.destination as? LocationDetailsViewController else { return }
            destVC.waypoint = waypoint
        }
    }
}

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func setMapViewDelegate() {
        mapView.delegate = self
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation,
                                              reuseIdentifier: Constant.calloutViewIdentifier)
        guard let waypoint = annotation as? Waypoint else {
            fatalError("Unable to cast MKAnnotation to Waypoint")
        }

        annotationView.canShowCallout = true
        annotationView.image = getAnnotationImage(for: waypoint.locationType)
        annotationView.leftCalloutAccessoryView = UIButton(frame: Constant.leftAccessoryViewSize)

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let thumbnailImageButton = view.leftCalloutAccessoryView as? UIButton else { return }
        guard let url = (view.annotation as? Waypoint)?.thumbnailImageUrl else { return }
        guard let imageData = NSData(contentsOf: url) else { return }
        guard let image = UIImage(data: imageData as Data) else { return }

        thumbnailImageButton.setImage(image, for: .normal)
    }

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: SegueIdentifier.showLocationPinDetails, sender: view)
    }
}
