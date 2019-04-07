//
//  UITextFieldExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

extension UITextField {
    func validate(_ validatorType: ValidatorType) throws {
        let validator = ValidatorFactory.validator(for: validatorType)
        guard let text = self.text else { return }

        do {
            try validator.validate(text)
            clearValidationErrorBorder()
        } catch let error {
            showValidationErrorBorder()
            throw error
        }
    }

    private func showValidationErrorBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
    }

    func clearValidationErrorBorder() {
        layer.borderWidth = 0
    }
}
