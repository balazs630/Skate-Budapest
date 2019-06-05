//
//  SubmitPlaceDescriptionViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 05. 30..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitPlaceDescriptionViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var coordinator: SubmitPlaceCoordinator?

    // MARK: Outlets
    @IBOutlet weak var graphicsImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: Button!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Actions
    @IBAction func nextButtonTap(_ sender: Any) {
        coordinator?.toSubmitPlaceTypeSelectorScreen()
    }
}

// MARK: Screen configuration
extension SubmitPlaceDescriptionViewController {
    private func configureSelf() {
        configureNavigationBar()
        configureImageView()
        configureLabels()
        configureButtons()
    }

    private func configureNavigationBar() {
        navigationItem.title = Texts.SubmitPlace.submitDescriptionNavBarTitle.localized
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = Theme.Color.primaryTurquoise
    }

    private func configureImageView() {
        graphicsImageView.image = Theme.Image.submitPlaceGraphics
    }

    private func configureLabels() {
        descriptionLabel.text = Texts.SubmitPlace.submitPlaceDescription.localized
        descriptionLabel.textColor = Theme.Color.textDark
    }

    private func configureButtons() {
        nextButton.setTitle(Texts.SubmitPlace.next.localized, for: .normal)
    }
}
