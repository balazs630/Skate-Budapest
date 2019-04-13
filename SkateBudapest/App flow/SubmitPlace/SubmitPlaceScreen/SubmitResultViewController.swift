//
//  SubmitResultViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitResultViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var coordinator: SubmitPlaceCoordinator?

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        navigationItem.title = Texts.SubmitPlace.submitSummaryNavBarTitle.localized
        navigationItem.hidesBackButton = true
    }

    // MARK: Actions
    @IBAction func doneButtonTap(_ sender: Any) {
        coordinator?.toSubmitPlaceTypeSelectorScreen()
    }
}
