//
//  SkateMapViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import MapKit

class SkateMapViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()

        LocationManager.shared.startTracking()
        mapView.delegate = self
        loadMapWaypointsFrom(url: Constant.dataSourceGPXUrl)
    }

    // MARK: Screen configuration
    private func configureSelf() {
        navigationItem.title = NSLocalizedString("mapNavBarTitle", comment: "")
        tabBarItem.title = Texts.SkateMap.mapTabBarTitle.localized
    }

    // MARK: Button actions
    @IBAction func centerMapOnUserLocation(_ sender: Any) {
        if let userLocation = LocationManager.shared.location {
            let latitudinalMeters = CLLocationDistance(10000)
            let longitudinalMeters = CLLocationDistance(10000)

            let viewRegion = MKCoordinateRegion.init(center: userLocation.coordinate,
                                                     latitudinalMeters: latitudinalMeters,
                                                     longitudinalMeters: longitudinalMeters)
            mapView.setRegion(viewRegion, animated: true)
        }
    }

    @IBAction func filterAnnotations(_ sender: Any) {
        guard let annotationFilterVC = storyboard?.instantiateViewController(withIdentifier: Constant.annotationFilter)
            as? AnnotationFilterViewController else { return }

        annotationFilterVC.modalPresentationStyle = .custom
        annotationFilterVC.view.frame.size.width = view.frame.width
        annotationFilterVC.transitioningDelegate = self
        annotationFilterVC.delegate = self

        present(annotationFilterVC, animated: true, completion: nil)
    }
}

// MARK: Map annotation operations
extension SkateMapViewController {
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

    private func filter(types: [LocationType]) {
        for annotation in mapView.annotations {
            if let waypoint = annotation as? Waypoint {
                mapView.view(for: annotation)?.isHidden = !types.contains(waypoint.type)
            }
        }
    }
}

// MARK: Navigation
extension SkateMapViewController {
    private func navigateToDetailsScreen(from view: UIView) {
        performSegue(withIdentifier: SegueIdentifier.showLocationPinDetails, sender: view)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let annotationView = sender as? MKAnnotationView
        guard let waypoint = annotationView?.annotation as? Waypoint else { return }
        guard segue.identifier != nil else { return }

        switch segue.identifier {
        case SegueIdentifier.showLocationPinDetails:
            guard let destVC = segue.destination as? LocationDetailsViewController else { return }
            destVC.waypoint = waypoint
        default:
            debugPrint("Unexpected segue identifier was given in: \(#file), line: \(#line)")
        }
    }
}

// MARK: MKMapViewDelegate methods
extension SkateMapViewController: MKMapViewDelegate {
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
        annotationView.image = getWaypointImage(for: waypoint.type)

        annotationView.leftCalloutAccessoryView = UIButton(frame: Constant.calloutImageViewSize)
        annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)

        return annotationView
    }

    private func getWaypointImage(for type: LocationType) -> UIImage {
        switch type {
        case .skatepark:
            return Theme.Icon.skateparkPin
        case .skateshop:
            return Theme.Icon.skateshopPin
        case .streetspot:
            return Theme.Icon.streetSpotPin
        }
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

// MARK: UIViewControllerTransitioningDelegate methods
extension SkateMapViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return HalfScreenModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: AnnotationFilterDelegate methods
extension SkateMapViewController: AnnotationFilterDelegate {
    func filterAnnotationsBy(types: [LocationType]) {
        return filter(types: types)
    }
}
