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

    // MARK: Screen configuration
    private func configureSelf() {
        navigationItem.title = Texts.SubmitPlace.submitTextsNavBarTitle.localized
    }

    // MARK: Actions:
    @IBAction func nextButtonTap(_ sender: Any) {
        saveUserInput()
        coordinator?.toSubmitImagesScreen(with: placeSuggestionDisplayItem)
    }
}

// MARK: User input handling
extension SubmitTextsViewController {
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
