//
//  SubmitPositionViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import MapKit

class SubmitPositionViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    private let placeWebService = PlaceWebService()
    weak var coordinator: SubmitPlaceCoordinator?
    var placeSuggestionDisplayItem: PlaceSuggestionDisplayItem?
    lazy var locationPin = MKPointAnnotation()

    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        loadUserInput()
        zoomOnLocationPin()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            saveUserInput()
            coordinator?.backToImagesScreen(with: placeSuggestionDisplayItem)
        }
    }

    // MARK: Screen configuration
    private func configureSelf() {
        navigationItem.title = Texts.SubmitPlace.submitPositionNavBarTitle.localized
        mapView.delegate = self
    }

    private func zoomOnLocationPin() {
        let viewRegion = MKCoordinateRegion.init(center: locationPin.coordinate,
                                                 latitudinalMeters: 5000,
                                                 longitudinalMeters: 5000)
        mapView.setRegion(viewRegion, animated: true)
    }

    // MARK: Actions
    @IBAction func submitButtonTap(_ sender: Any) {
        saveUserInput()
        sendPlaceSuggestion()
    }

    private func sendPlaceSuggestion() {
        addActivityIndicator(title: Texts.General.loading.localized)

        guard let displayItem = placeSuggestionDisplayItem else { return }
        let placeSuggestionApiModel = PlaceSuggestionApiModel(displayItem: displayItem)

        placeWebService.postPlaceSuggestion(newPlace: placeSuggestionApiModel) { result in
            self.removeActivityIndicator()

            switch result {
            case .success:
                self.coordinator?.toSubmitSummaryScreen(with: self.placeSuggestionDisplayItem)
            case .failure(let error):
                self.present(ResultAlertDialog.build(title: error.title, message: error.message), animated: true)
            }
        }
    }
}

// MARK: User input handling
extension SubmitPositionViewController {
    private func saveUserInput() {
        placeSuggestionDisplayItem?.coordinate = locationPin.coordinate
    }

    private func loadUserInput() {
        guard let displayItem = placeSuggestionDisplayItem else { return }
        locationPin.coordinate = displayItem.coordinate
        mapView.addAnnotation(locationPin)
    }
}

// MARK: MKMapViewDelegate methds
extension SubmitPositionViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "")
            pinAnnotationView.isDraggable = true
            pinAnnotationView.animatesDrop = true

            return pinAnnotationView
        }

        return nil
    }
}
