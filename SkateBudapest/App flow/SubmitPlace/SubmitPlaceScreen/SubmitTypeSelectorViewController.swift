//
//  SubmitTypeSelectorViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 15..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitTypeSelectorViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var coordinator: SubmitPlaceCoordinator?
    var placeSuggestionDisplayItem: PlaceSuggestionDisplayItem?

    // MARK: Outlets
    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet weak var skateparkLabel: UILabel!
    @IBOutlet weak var streetspotLabel: UILabel!
    @IBOutlet weak var skateshopLabel: UILabel!

    @IBOutlet weak var skateparkVideoView: VideoView!
    @IBOutlet weak var skatespotVideoView: VideoView!
    @IBOutlet weak var skateshopVideoView: VideoView!
    @IBOutlet var videoViewCollection: [VideoView]!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    override func viewDidLayoutSubviews() {
        stackView.layoutIfNeeded()
        configureVideoViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        videoViewCollection.forEach { $0.play() }
    }

    override func viewDidDisappear(_ animated: Bool) {
        videoViewCollection.forEach { $0.stop() }
    }
}

// MARK: Screen configuration
extension SubmitTypeSelectorViewController {
    private func configureSelf() {
        configureNavigationBar()
        configureLabels()
    }

    private func configureNavigationBar() {
        navigationItem.title = Texts.SubmitPlace.submitTypeNavBarTitle.localized
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = Theme.Color.primaryTurquoise
    }

    private func configureLabels() {
        skateparkLabel.text = Texts.SkateMap.skateparkType.localized
        streetspotLabel.text = Texts.SkateMap.streetspotType.localized
        skateshopLabel.text = Texts.SkateMap.skateshopType.localized
    }

    private func configureVideoViews() {
        skateparkVideoView.configure(filename: "skate")
        skatespotVideoView.configure(filename: "skate")
        skateshopVideoView.configure(filename: "skate")
    }
}

// MARK: Actions
extension SubmitTypeSelectorViewController {
    @IBAction func skateparkTypeTap(_ sender: Any) {
        saveUserInput(type: .skatepark)
        coordinator?.toSubmitTextsScreen(with: placeSuggestionDisplayItem)
    }

    @IBAction func streetSpotTypeTap(_ sender: Any) {
        saveUserInput(type: .streetspot)
        coordinator?.toSubmitTextsScreen(with: placeSuggestionDisplayItem)
    }

    @IBAction func skateshopTypeTap(_ sender: Any) {
        saveUserInput(type: .skateshop)
        coordinator?.toSubmitTextsScreen(with: placeSuggestionDisplayItem)
    }
}

// MARK: User input handling
extension SubmitTypeSelectorViewController {
    private func saveUserInput(type: WaypointType) {
        placeSuggestionDisplayItem?.type = type.rawValue
    }
}
