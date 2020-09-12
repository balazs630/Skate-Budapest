//
//  EmailFormatValidator.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

struct EmailFormatValidator {
    let pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
}

// MARK: Validation
extension EmailFormatValidator: ValidatorConvertible {
    func validate(_ value: Any?) throws {
        guard let text = value as? String,
            text.range(of: pattern, options: .regularExpression) != nil
        else {
            throw ValidationError(message: Texts.Validation.invalidEmailFormat.localized)
        }
    }
}
