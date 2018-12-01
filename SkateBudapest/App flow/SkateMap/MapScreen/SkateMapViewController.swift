//
//  SkateMapViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import MapKit

class SkateMapViewController: UIViewController {
    // MARK: Properties
    private let placeService = PlaceService()

    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()

        LocationService.shared.startTracking()
        mapView.delegate = self
        loadMapWaypoints()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        navigationItem.title = Texts.SkateMap.mapNavBarTitle.localized
        configureTabBarTexts(with: [Texts.SkateMap.mapTabBarTitle.localized,
                                    Texts.SendSpace.sendPlaceTabBarTitle.localized])
    }

    // MARK: Button actions
    @IBAction func centerMapButtonTap(_ sender: Any) {
        if let userLocation = LocationService.shared.location {
            let latitudinalMeters = CLLocationDistance(10000)
            let longitudinalMeters = CLLocationDistance(10000)

            let viewRegion = MKCoordinateRegion.init(center: userLocation.coordinate,
                                                     latitudinalMeters: latitudinalMeters,
                                                     longitudinalMeters: longitudinalMeters)
            mapView.setRegion(viewRegion, animated: true)
        }
    }

    @IBAction func filterButtonTap(_ sender: Any) {
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
    private func loadMapWaypoints() {
        clearWaypoints()
        placeService.getWaypoints { waypoints, _ in
            guard let waypoints = waypoints else { return }
            self.add(waypoints: waypoints.filter { $0.status == .active })
        }
    }

    private func clearWaypoints() {
        mapView.removeAnnotations(mapView.annotations)
    }

    private func add(waypoints: [Place]) {
        mapView.addAnnotations(waypoints)
        mapView.showAnnotations(waypoints, animated: true)
    }

    private func filter(types: [WaypointType]) {
        mapView.annotations.forEach { annotation in
            if let waypoint = annotation as? Place {
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
        guard let waypoint = annotationView?.annotation as? Place else { return }
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

        guard let waypoint = annotation as? Place else {
            fatalError("Unable to cast MKAnnotation to Waypoint")
        }

        annotationView.canShowCallout = true
        annotationView.image = getWaypointImage(for: waypoint.type)

        annotationView.leftCalloutAccessoryView = UIButton(frame: Constant.calloutImageViewSize)
        annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)

        return annotationView
    }

    private func getWaypointImage(for type: WaypointType) -> UIImage {
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
                let urlString = (view.annotation as? Place)?.thumbnailUrl,
                let url = URL(string: urlString),
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
    func filterAnnotationsBy(types: [WaypointType]) {
        return filter(types: types)
    }
}
