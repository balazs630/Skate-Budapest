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
    // MARK: Properties
    private let locationManager = CLLocationManager()

    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        enableLocationServices()
        setMapViewDelegate()
        loadMapWaypointsFrom(url: Constant.dataSourceGPXUrl)
    }

    // MARK: Button actions
    @IBAction func centerMapOnUserLocation(_ sender: Any) {
        if let userLocation = locationManager.location {
            let latitudinalMeters = CLLocationDistance(10000)
            let longitudinalMeters = CLLocationDistance(10000)

            let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate,
                                                                latitudinalMeters,
                                                                longitudinalMeters)
            mapView.setRegion(viewRegion, animated: true)
        }
    }

    // MARK: Map waypoint operations
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

    private func getWaypointImage(for locationType: LocationType) -> UIImage {
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

// MARK: CLLocationManagerDelegate methods
extension MapViewController: CLLocationManagerDelegate {
    private func enableLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            locationManager.stopUpdatingLocation()
        case .notDetermined, .authorizedAlways:
            break
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
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }

        guard let waypoint = annotation as? Waypoint else {
            fatalError("Unable to cast MKAnnotation to Waypoint")
        }

        annotationView.canShowCallout = true
        annotationView.image = getWaypointImage(for: waypoint.locationType)

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
