//
//  UIImageViewExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 19..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

extension Array where Element == UIImageView {
    func images() -> [UIImage] {
        var images = [UIImage]()
        self.forEach { imageView in
            images.append(imageView.image!)
        }
        return images
    }
}

extension UIImageView {
    func validate(_ validatorType: ValidatorType) throws {
        let validator = ValidatorFactory.validator(for: validatorType)

        do {
            try validator.validate(image)
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
