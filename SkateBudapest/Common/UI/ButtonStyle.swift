//
//  ButtonStyle.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 06. 10..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case next
    case action

    var appearance: ButtonAppearance {
        switch self {
        case .next:
            return ButtonAppearance(font: .systemFont(ofSize: 20, weight: .medium),
                                    textColor: .white,
                                    backgroundColor: Theme.Color.lightBlue,
                                    radious: 20,
                                    contentInsets: UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32))
        case .action:
            return ButtonAppearance(font: .systemFont(ofSize: 20, weight: .medium),
                                    textColor: .white,
                                    backgroundColor: Theme.Color.lightBlue,
                                    radious: 10,
                                    contentInsets: UIEdgeInsets())
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
         radious: CGFloat,
         contentInsets: UIEdgeInsets) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.radious = radious
        self.contentInsets = contentInsets
    }
}
