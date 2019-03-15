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
    private let placeCachingService = PlaceCachingService()
    weak var coordinator: SkateMapCoordinator?

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
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        navigationItem.title = Texts.SkateMap.mapNavBarTitle.localized
        navigationController?.navigationBar.barTintColor = Theme.Color.primaryTurquoise

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Theme.Icon.filteringEmpty,
            style: .done,
            target: self,
            action: #selector(toFilteringScreen))
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
}

// MARK: Map annotation operations
extension SkateMapViewController {
    private func loadMapWaypoints() {
        clearWaypoints()
        placeCachingService.getPlaces { result in
            switch result {
            case .success(let waypoints):
                self.add(waypoints: waypoints.filter { $0.status == .active })
            case .failure(let error):
                let alertController = SimpleAlertDialog.build(title: error.title, message: error.message)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    private func clearWaypoints() {
        mapView.removeAnnotations(mapView.annotations)
    }

    private func add(waypoints: [PlaceDisplayItem]) {
        mapView.addAnnotations(waypoints)
        mapView.showAnnotations(waypoints, animated: true)
    }

    private func filter(by selectedTypes: [WaypointType]) {
        mapView.annotations.forEach { annotation in
            if let waypoint = annotation as? PlaceDisplayItem {
                mapView.view(for: annotation)?.isHidden = !selectedTypes.contains(waypoint.type)
            }
        }
    }

    private func changeFilteringIcon(isFiltered: Bool) {
        let buttonItem = navigationItem.rightBarButtonItem
        buttonItem?.image = isFiltered ? Theme.Icon.filteringFull : Theme.Icon.filteringEmpty
        navigationItem.rightBarButtonItem = buttonItem
    }
}

// MARK: Navigation
extension SkateMapViewController {
    @objc private func toFilteringScreen() {
        coordinator?.toFilteringScreen(using: self)
    }

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
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }

        guard let waypoint = annotation as? PlaceDisplayItem else {
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

// MARK: UIViewControllerTransitioningDelegate methods
extension SkateMapViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return HalfScreenModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: PlaceFilterDelegate methods
extension SkateMapViewController: PlaceFilterDelegate {
    func filterAnnotations(by selectedTypes: [WaypointType]) {
        changeFilteringIcon(isFiltered: WaypointType.allCases.count != selectedTypes.count)
        return filter(by: selectedTypes)
    }
}
