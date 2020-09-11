//
//  SubmitResultViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitResultViewController: UIViewController {
    // MARK: Properties
    weak var coordinator: SubmitPlaceCoordinator?
    private let impactGenerator = UIImpactFeedbackGenerator()

    // MARK: Outlets
    @IBOutlet private weak var checkmarkVideoView: VideoView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var backButton: Button!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        impactGenerator.impactOccurred()
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
        toSubmitPlaceDescriptionScreen()
    }

    // MARK: Navigation
    private func toSubmitPlaceDescriptionScreen() {
        coordinator?.toSubmitPlaceDescriptionScreen()
    }
}
