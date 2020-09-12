//
//  ImageIsRequiredValidator.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 07..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

struct ImageIsRequiredValidator { }

// MARK: Validation
extension ImageIsRequiredValidator: ValidatorConvertible {
    func validate(_ value: Any?) throws {
        guard let image = value as? UIImage,
            image.cgImage != nil
        else {
            throw ValidationError(message: Texts.Validation.imageRequired.localized)
        }
    }
}
