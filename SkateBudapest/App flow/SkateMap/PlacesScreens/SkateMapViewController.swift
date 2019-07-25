//
//  SkateMapViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import MapKit

class SkateMapViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var coordinator: SkateMapCoordinator?
    private let placeCachingService = PlaceCachingService()
    private let placeFilterController = PlaceFilterController()
    var waypoints: [PlaceDisplayItem]! {
        didSet {
            updateMapWaypoints()
        }
    }

    // MARK: Outlets
    @IBOutlet weak var placesMapView: MKMapView!
    @IBOutlet weak var centerLocationButton: UIButton!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()

        LocationService.shared.startTracking()
        loadMapWaypoints()
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent != nil {
            updateMapWaypoints()
        }
    }

    // MARK: Screen configuration
    private func configureSelf() {
        placesMapView.delegate = self
        placesMapView.setRegion(Constant.defaultCityRegion, animated: true)
    }

    // MARK: Actions
    @IBAction func changeMapTypeTap(_ sender: Any) {
        placesMapView.toggleMapTypeBetween(.standard, .hybrid)
    }

    @IBAction func centerMapButtonTap(_ sender: Any) {
        guard LocationService.shared.location != nil else { return }
        placesMapView.toggleUserTrackingMode()
    }
}

// MARK: Waypoint operations
extension SkateMapViewController {
    private func loadMapWaypoints() {
        addActivityIndicator(title: Texts.General.loading.localized)

        placeCachingService.getPlaces { [weak self] result in
            guard let `self` = self else { return }
            self.removeActivityIndicator()

            switch result {
            case .success(let waypoints):
                self.waypoints = waypoints
            case .failure(let error):
                self.present(ResultAlertDialog.build(title: error.title, message: error.message), animated: true)
            }
        }
    }

    func updateMapWaypoints() {
        guard let mapView = placesMapView else { return }
        waypoints?.forEach { annotation in
            if placeFilterController.visibility(for: annotation) {
                mapView.addAnnotation(annotation)
            } else {
                mapView.removeAnnotation(annotation)
            }
        }
    }
}

// MARK: Navigation
extension SkateMapViewController {
    private func toDetailsScreen(from view: MKAnnotationView) {
        guard let place = view.annotation as? PlaceDisplayItem else { return }
        coordinator?.toPlaceDetailsScreen(place: place)
    }
}

// MARK: MKMapViewDelegate methods
extension SkateMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation,
                                              reuseIdentifier: Constant.calloutViewIdentifier)
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        guard let waypoint = annotation as? PlaceDisplayItem else {
            fatalError("Unable to cast MKAnnotation to PlaceDisplayItem")
        }

        annotationView.canShowCallout = true
        annotationView.image = waypoint.type.image
        annotationView.leftCalloutAccessoryView = UIButton(frame: Constant.calloutImageViewSize)
        annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        switch mode {
        case .none:
            centerLocationButton.setImage(Theme.Icon.locationTrackingNone, for: .normal)
        case .follow:
            centerLocationButton.setImage(Theme.Icon.locationTrackingFollow, for: .normal)
        case .followWithHeading:
            centerLocationButton.setImage(Theme.Icon.locationTrackingHeading, for: .normal)
        @unknown default:
            break
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let leftCalloutAccessoryButton = view.leftCalloutAccessoryView as? UIButton,
                let imageData = (view.annotation as? PlaceDisplayItem)?.thumbnailImageData,
                let image = UIImage(data: imageData) else {
                    return
        }

        leftCalloutAccessoryButton.setImage(image, for: .normal)
        leftCalloutAccessoryButton.isUserInteractionEnabled = false
    }

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        toDetailsScreen(from: view)
    }
}