//
//  SubmitTextsViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitTextsViewController: UIViewController {
    // MARK: Properties
    weak var coordinator: SubmitPlaceCoordinator?
    var placeSuggestionDisplayItem: PlaceSuggestionDisplayItem?

    // MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailDescriptionLabel: DescriptionLabel!

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var infoTextView: TextView!
    @IBOutlet private weak var contactEmailTextField: UITextField!

    @IBOutlet private weak var nextButton: Button!

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
        infoTextView.delegate = self

        contactEmailTextField.delegate = self
        contactEmailTextField.textContentType = .emailAddress
        contactEmailTextField.keyboardType = .emailAddress
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
            ResultAlertDialog(title: error.title, message: error.message).show()
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
