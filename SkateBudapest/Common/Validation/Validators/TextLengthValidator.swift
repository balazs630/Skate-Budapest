//
//  TextLengthValidator.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

struct TextLengthValidator {
    // MARK: Properties
    let range: ClosedRange<Int>

    // MARK: Initializers
    init(range: ClosedRange<Int>) {
        self.range = range
    }
}

// MARK: Validation
extension TextLengthValidator: ValidatorConvertible {
    func validate(_ value: Any?) throws {
        guard let text = value as? String else { return }

        if text.count < range.lowerBound {
            throw ValidationError(message: "Text should be longer than \(range.lowerBound) character!")
        } else if text.count > range.upperBound {
            throw ValidationError(message: "Text should be shorter than \(range.upperBound) character!")
        }
    }
}
