//
//  Button.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 06. 09..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class Button: UIButton {
    // MARK: Properties
    var style: ButtonStyle = .action {
        didSet {
            setupAppearance()
        }
    }

    // MARK: View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }

    // MARK: Setup appearance
    private func setupAppearance() {
        setTitle("", for: .normal)
        setTitleColor(style.appearance.textColor, for: .normal)
        titleLabel?.font = style.appearance.font

        layer.backgroundColor = style.appearance.backgroundColor.cgColor
        layer.cornerRadius = style.appearance.radious
        contentEdgeInsets = style.appearance.contentInsets
    }
}
