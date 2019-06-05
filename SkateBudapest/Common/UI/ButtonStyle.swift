//
//  ButtonStyle.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 06. 10..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case primary
    case secondary

    var appearance: ButtonAppearance {
        switch self {
        case .primary:
            return ButtonAppearance(font: .systemFont(ofSize: 20, weight: .medium),
                                    textColor: .black,
                                    backgroundColor: Theme.Color.primaryTurquoise)
        case .secondary:
            return ButtonAppearance(font: .systemFont(ofSize: 18, weight: .medium),
                                    textColor: .black,
                                    backgroundColor: .lightGray)
        }
    }
}

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
         radious: CGFloat = 20,
         contentInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32)) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.radious = radious
        self.contentInsets = contentInsets
    }
}
