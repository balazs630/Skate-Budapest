//
//  EmailFormatValidator.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

struct EmailFormatValidator { }

// MARK: Validation
extension EmailFormatValidator: ValidatorConvertible {
    func validate(_ value: Any?) throws {
        let pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        guard
            let text = value as? String,
            text.range(of: pattern, options: .regularExpression) != nil
            else {
                throw ValidationError(message: "Invalid e-mail address format!")
        }
    }
}