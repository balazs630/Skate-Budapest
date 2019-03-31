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

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        navigationItem.title = Texts.SubmitPlace.submitTypeNavBarTitle.localized
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = Theme.Color.primaryTurquoise
    }

    // MARK: Actions
    @IBAction func skateparkTypeTap(_ sender: Any) {
        saveUserInput(type: "skatepark")
        coordinator?.toSubmitTextsScreen(with: placeSuggestionDisplayItem)
    }

    @IBAction func streetSpotTypeTap(_ sender: Any) {
        saveUserInput(type: "streetspot")
        coordinator?.toSubmitTextsScreen(with: placeSuggestionDisplayItem)
    }

    @IBAction func skateshopTypeTap(_ sender: Any) {
        saveUserInput(type: "skateshop")
        coordinator?.toSubmitTextsScreen(with: placeSuggestionDisplayItem)
    }
}

// MARK: User input handling
extension SubmitTypeSelectorViewController {
    private func saveUserInput(type: String) {
        placeSuggestionDisplayItem?.type = type
    }
}
