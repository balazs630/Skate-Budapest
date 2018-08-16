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
        loadMapWaypointsFrom(url: Constant.dataSourceGPXUrl)
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
    private func navigateToDetailsScreen(from view: UIView) {
        performSegue(withIdentifier: SegueIdentifier.showLocationPinDetails, sender: view)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let annotationView = sender as? MKAnnotationView
        guard let waypoint = annotationView?.annotation as? Waypoint else { return }

        if segue.identifier == SegueIdentifier.showLocationPinDetails {
            guard let destVC = segue.destination as? LocationDetailsViewController else { return }
            destVC.waypoint = waypoint
        }
    }
}

// MARK: MKMapViewDelegate methods
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

        annotationView.leftCalloutAccessoryView = UIButton(frame: Constant.calloutImageViewSize)
        annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let leftCalloutAccessoryButton = view.leftCalloutAccessoryView as? UIButton,
                let url = (view.annotation as? Waypoint)?.thumbnailImageUrl,
                let imageData = NSData(contentsOf: url),
                let image = UIImage(data: imageData as Data) else {
                    return
        }

        leftCalloutAccessoryButton.setImage(image, for: .normal)
        leftCalloutAccessoryButton.isUserInteractionEnabled = false
    }

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        navigateToDetailsScreen(from: view)
    }
}
