//
//  SubmitTypeSelectorViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 15..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitTypeSelectorViewController: UIViewController {
    // MARK: Properties
    weak var coordinator: SubmitPlaceCoordinator?
    var placeSuggestionDisplayItem: PlaceSuggestionDisplayItem?

    // MARK: Outlets
    @IBOutlet private weak var descriptionLabel: DescriptionLabel!
    @IBOutlet private weak var stackView: UIStackView!

    @IBOutlet private weak var skateparkLabel: UILabel!
    @IBOutlet private weak var streetspotLabel: UILabel!
    @IBOutlet private weak var skateshopLabel: UILabel!

    @IBOutlet private weak var skateparkVideoView: VideoView!
    @IBOutlet private weak var streetSpotVideoView: VideoView!
    @IBOutlet private weak var skateshopVideoView: VideoView!
    @IBOutlet private var videoViewCollection: [VideoView]!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stackView.layoutIfNeeded()
        configureVideoViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoViewCollection.forEach { $0.play() }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        videoViewCollection.forEach {
            $0.commonDeinit()
        }
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
    }

    private func configureLabels() {
        descriptionLabel.text = Texts.SubmitPlace.submitTypeDescription.localized
        skateparkLabel.text = Texts.SkateMap.skateparkType.localized
        streetspotLabel.text = Texts.SkateMap.streetspotType.localized
        skateshopLabel.text = Texts.SkateMap.skateshopType.localized
    }

    func configureVideoViews() {
        skateparkVideoView.configure(filename: Constant.Video.skatepark)
        streetSpotVideoView.configure(filename: Constant.Video.streetspot)
        skateshopVideoView.configure(filename: Constant.Video.skateshop)
    }
}

// MARK: Actions
extension SubmitTypeSelectorViewController {
    @IBAction func skateparkTypeTap(_ sender: Any) {
        saveUserInput(type: .skatepark)
        toSubmitTextsScreen()
    }

    @IBAction func streetSpotTypeTap(_ sender: Any) {
        saveUserInput(type: .streetspot)
        toSubmitTextsScreen()
    }

    @IBAction func skateshopTypeTap(_ sender: Any) {
        saveUserInput(type: .skateshop)
        toSubmitTextsScreen()
    }
}

// MARK: Navigation
extension SubmitTypeSelectorViewController {
    private func toSubmitTextsScreen() {
        coordinator?.toSubmitTextsScreen(with: placeSuggestionDisplayItem)
    }
}

// MARK: User input handling
extension SubmitTypeSelectorViewController {
    private func saveUserInput(type: WaypointType) {
        placeSuggestionDisplayItem?.type = type.rawValue
    }
}
