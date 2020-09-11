//
//  PlaceReportingViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2020. 04. 12..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

import UIKit

class PlaceReportingViewController: UIViewController {
    // MARK: Properties
    private let placeWebService = PlaceWebService()
    var place: PlaceDisplayItem!

    // MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!

    @IBOutlet private weak var reportTextTitleLabel: UILabel!
    @IBOutlet private weak var reportTextView: UITextView!
    @IBOutlet private weak var emailTextTitleLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var submitButton: Button!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Actions
    @IBAction func submitButtonDidTap(_ sender: Any) {
        do {
            try validateInput()
            let report = PlaceReportApiModel(placeId: place.id,
                                             placeName: place.name,
                                             senderEmail: emailTextField.text ?? "",
                                             reportText: reportTextView.text)
            submitPlaceReport(with: report)
        } catch let error as ValidationError {
            ResultAlertDialog(title: error.title, message: error.message).show()
        } catch { }
    }

    private func submitPlaceReport(with report: PlaceReportApiModel) {
        addActivityIndicator(title: Texts.General.loading.localized)

        placeWebService.postPlaceReport(report: report) { [weak self] result in
            guard let `self` = self else { return }
            self.removeActivityIndicator()

            switch result {
            case .success:
                let alert = ResultAlertDialog(title: Texts.PlaceReport.successAlertTitle.localized,
                                              message: Texts.PlaceReport.successAlertMessage.localized,
                                              alertAction: .custom)
                alert.addAction(UIAlertAction(title: Texts.General.ok.localized,
                                              style: .default,
                                              handler: { [weak self] _ in
                    self?.dismiss(animated: true)
                }))

                alert.show()
            case .failure(let error):
                ResultAlertDialog(title: error.title, message: error.message).show()
            }
        }
    }
}

// MARK: Screen configuration
extension PlaceReportingViewController {
    private func configureSelf() {
        configureLabels()
        configureInputFields()
        configureButtons()
        setupAppearance()
    }

    private func configureLabels() {
        titleLabel.text = Texts.PlaceReport.title.localized
        subTitleLabel.text = Texts.PlaceReport.subTitle.localized
        reportTextTitleLabel.text = Texts.PlaceReport.reportNotes.localized
        emailTextTitleLabel.text = Texts.PlaceReport.email.localized
    }

    private func configureInputFields() {
        reportTextView.delegate = self

        emailTextField.delegate = self
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
    }

    private func configureButtons() {
        submitButton.style = .action
        submitButton.setTitle(Texts.PlaceReport.send.localized, for: .normal)
    }

    private func setupAppearance() {
        view.backgroundColor = Theme.Color.primaryTurquoise
    }
}

// MARK: User input handling
extension PlaceReportingViewController {
    private func validateInput() throws {
        try reportTextView.validate(.textLengthBetween(10...500))
        try emailTextField.validate(.emailFormat)
    }
}

// MARK: UITextFieldDelegate methods
extension PlaceReportingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        textField.clearValidationErrorBorder()
        return true
    }
}

// MARK: UITextViewDelegate methods
extension PlaceReportingViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textView.clearValidationErrorBorder()
    }
}
