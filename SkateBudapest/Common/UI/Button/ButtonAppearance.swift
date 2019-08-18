//
//  ButtonAppearance.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 08. 18..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

struct ButtonAppearance {
    // MARK: Properties
    var backgroundColor: UIColor
    var font: UIFont
    var textColor: UIColor
    var radious: CGFloat
    var contentInsets: UIEdgeInsets

    // MARK: Initializers
    init(font: UIFont,
         textColor: UIColor,
         backgroundColor: UIColor,
         radious: CGFloat,
         contentInsets: UIEdgeInsets) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.radious = radious
        self.contentInsets = contentInsets
    }
}
