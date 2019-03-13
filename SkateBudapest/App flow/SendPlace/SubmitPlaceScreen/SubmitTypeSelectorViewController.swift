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

    // MARK: Outlets

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
    @IBAction func skateParkTypeTap(_ sender: Any) {
        coordinator?.toSubmitTextsScreen()
    }

    @IBAction func streetSpotTypeTap(_ sender: Any) {
        coordinator?.toSubmitTextsScreen()
    }

    @IBAction func skateshopTypeTap(_ sender: Any) {
        coordinator?.toSubmitTextsScreen()
    }
}
