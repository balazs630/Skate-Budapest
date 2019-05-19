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
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var contactEmailTextField: UITextField!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        loadUserInput()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            saveUserInput()
            coordinator?.backToSubmitTypeSelectorScreen(with: placeSuggestionDisplayItem)
        }
    }

    // MARK: Screen configuration
    private func configureSelf() {
        navigationItem.title = Texts.SubmitPlace.submitTextsNavBarTitle.localized

        titleTextField.delegate = self
        contactEmailTextField.delegate = self
        infoTextView.delegate = self
    }

    // MARK: Actions
    @IBAction func nextButtonTap(_ sender: Any) {
        do {
            try validateInput()
            saveUserInput()
            coordinator?.toSubmitImagesScreen(with: placeSuggestionDisplayItem)
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
