//
//  ValidatorFactory.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import CoreGraphics

protocol ValidatorConvertible {
    func validate(_ value: Any?) throws
}

enum ValidatorType {
    case emailFormat
    case textLengthBetween(ClosedRange<Int>)
    case imageSizeBiggerThan(CGSize)
    case imageIsRequired
}

enum ValidatorFactory {
    static func validator(for type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .emailFormat:
            return EmailFormatValidator()
        case .textLengthBetween(let range):
            return TextLengthValidator(range: range)
        case .imageSizeBiggerThan(let size):
            return ImageSizeBiggerThanValidator(size: size)
        case .imageIsRequired:
            return ImageIsRequiredValidator()
        }
    }
}
