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
    @IBOutlet weak var centerLocationButton: UIButton!
    @IBOutlet weak var descriptionLabel: DescriptionLabel!
    @IBOutlet weak var submitButton: Button!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()

        LocationService.shared.startTracking()
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
        configureNavigationBar()
        configureMapView()
        configureLabels()
        configureButtons()
    }

    private func configureNavigationBar() {
        navigationItem.title = Texts.SubmitPlace.submitPositionNavBarTitle.localized
    }

    private func configureMapView() {
        mapView.delegate = self
        NSLayoutConstraint.activate([
            mapView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6)
        ])
    }

    private func configureLabels() {
        descriptionLabel.text = Texts.SubmitPlace.submitPositionDescription.localized
    }

    private func configureButtons() {
        submitButton.style = .next
        submitButton.setTitle(Texts.SubmitPlace.submit.localized, for: .normal)
    }

    private func zoomOnLocationPin() {
        let viewRegion = MKCoordinateRegion.init(center: locationPin.coordinate,
                                                 latitudinalMeters: 5000,
                                                 longitudinalMeters: 5000)
        mapView.setRegion(viewRegion, animated: true)
    }

    // MARK: Actions
    @IBAction func changeMapLayerTap(_ sender: Any) {
        mapView.toggleMapTypeBetween(.standard, .hybrid)
    }

    @IBAction func centerMapButtonTap(_ sender: Any) {
        guard LocationService.shared.location != nil else { return }
        mapView.toggleUserTrackingMode()
    }

    @IBAction func submitButtonTap(_ sender: Any) {
        do {
            try validateInput()
            saveUserInput()
            sendPlaceSuggestion()
        } catch let error as ValidationError {
            present(ResultAlertDialog.build(title: error.title, message: error.message), animated: true)
        } catch { }
    }

    private func sendPlaceSuggestion() {
        addActivityIndicator(title: Texts.General.uploading.localized)

        guard let displayItem = placeSuggestionDisplayItem else { return }
        let placeSuggestionApiModel = PlaceSuggestionApiModel(displayItem: displayItem)

        placeWebService.postPlaceSuggestion(newPlace: placeSuggestionApiModel) { result in
            self.removeActivityIndicator()

            switch result {
            case .success:
                self.coordinator?.toSubmitSummaryScreen()
            case .failure(let error):
                self.present(ResultAlertDialog.build(title: error.title, message: error.message), animated: true)
            }
        }
    }
}

// MARK: User input handling
extension SubmitPositionViewController {
    private func validateInput() throws {
        if locationPin.coordinate == Constant.defaultCityCoordinate {
            throw ValidationError(message: Texts.Validation.mustChangeCoordinates.localized)
        }
    }

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
}
