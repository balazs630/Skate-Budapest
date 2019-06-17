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

    // MARK: Outlets
    @IBOutlet weak var checkmarkVideoView: VideoView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: Button!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureVideoView()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        configureNavigationBar()
        configureLabels()
        configureButtons()
    }

    private func configureNavigationBar() {
        navigationItem.title = Texts.SubmitPlace.submitResultNavBarTitle.localized
        navigationItem.hidesBackButton = true
    }

    private func configureLabels() {
        titleLabel.text = Texts.SubmitPlace.submitResultTitle.localized
    }

    private func configureButtons() {
        backButton.style = .next
        backButton.setTitle(Texts.General.back.localized, for: .normal)
    }

    private func configureVideoView() {
        checkmarkVideoView.configure(filename: Constant.Video.checkmark)
        checkmarkVideoView.isLoop = false
        checkmarkVideoView.play()
    }

    // MARK: Actions
    @IBAction func doneButtonTap(_ sender: Any) {
        coordinator?.toSubmitPlaceDescriptionScreen()
    }
}
