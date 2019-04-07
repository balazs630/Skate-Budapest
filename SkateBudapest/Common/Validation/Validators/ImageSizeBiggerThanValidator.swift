//
//  ImageSizeBiggerThanValidator.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

struct ImageSizeBiggerThanValidator {
    // MARK: Properties
    let size: CGSize

    // MARK: Initializers
    init(size: CGSize) {
        self.size = size
    }
}

// MARK: Validation
extension ImageSizeBiggerThanValidator: ValidatorConvertible {
    func validate(_ value: Any?) throws {
        guard
            let image = value as? UIImage,
            image.size.isGreaterOrEqual(to: size)
            else {
                throw ValidationError(message: "Image should be bigger than \(size.width)x\(size.height) pixel!")
        }
    }
}
