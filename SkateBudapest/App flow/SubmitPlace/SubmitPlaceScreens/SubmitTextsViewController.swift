//
//  SubmitTextsViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitTextsViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var coordinator: SubmitPlaceCoordinator?
    var placeSuggestionDisplayItem: PlaceSuggestionDisplayItem?

    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailDescriptionLabel: DescriptionLabel!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var infoTextView: TextView!
    @IBOutlet weak var contactEmailTextField: UITextField!

    @IBOutlet weak var nextButton: Button!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        loadUserInput()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            saveUserInput()
            backToSubmitTypeSelectorScreen()
        }
    }

    // MARK: Screen configuration
    private func configureSelf() {
        configureNavigationBar()
        configureLabels()
        configureInputFields()
        configureButtons()
    }

    private func configureNavigationBar() {
        navigationItem.title = Texts.SubmitPlace.submitTextsNavBarTitle.localized
    }

    private func configureLabels() {
        titleLabel.text = Texts.SubmitPlace.submitTextsTitle.localized
        descriptionLabel.text = Texts.SubmitPlace.submitTextsDescription.localized
        emailLabel.text = Texts.SubmitPlace.submitTextsEmail.localized
        emailDescriptionLabel.text = Texts.SubmitPlace.submitTextsEmailDescription.localized
    }

    private func configureInputFields() {
        titleTextField.delegate = self
        contactEmailTextField.delegate = self
        infoTextView.delegate = self
    }

    private func configureButtons() {
        nextButton.style = .next
        nextButton.setTitle(Texts.SubmitPlace.next.localized, for: .normal)
    }

    // MARK: Actions
    @IBAction func nextButtonTap(_ sender: Any) {
        do {
            try validateInput()
            saveUserInput()
            toSubmitImagesScreen()
        } catch let error as ValidationError {
            present(ResultAlertDialog.build(title: error.title, message: error.message), animated: true)
        } catch { }
    }
}

// MARK: User input handling
extension SubmitTextsViewController {
    private func validateInput() throws {
        try titleTextField.validate(.textLengthBetween(8...50))
        try infoTextView.validate(.textLengthBetween(20...500))
        try contactEmailTextField.validate(.emailFormat)
    }

    private func saveUserInput() {
        placeSuggestionDisplayItem?.name = titleTextField.text ?? ""
        placeSuggestionDisplayItem?.info = infoTextView.text ?? ""
        placeSuggestionDisplayItem?.senderEmail = contactEmailTextField.text ?? ""
    }

    private func loadUserInput() {
        titleTextField.text = placeSuggestionDisplayItem?.name
        infoTextView.text = placeSuggestionDisplayItem?.info
        contactEmailTextField.text = placeSuggestionDisplayItem?.senderEmail
    }
}

// MARK: Navigation
extension SubmitTextsViewController {
    private func toSubmitImagesScreen() {
        coordinator?.toSubmitImagesScreen(with: placeSuggestionDisplayItem)
    }

    private func backToSubmitTypeSelectorScreen() {
        coordinator?.backToSubmitTypeSelectorScreen(with: placeSuggestionDisplayItem)
    }
}

// MARK: UITextFieldDelegate methods
extension SubmitTextsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        textField.clearValidationErrorBorder()
        return true
    }
}

// MARK: UITextViewDelegate methods
extension SubmitTextsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textView.clearValidationErrorBorder()
    }
}
