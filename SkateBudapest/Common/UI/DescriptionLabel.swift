//
//  DescriptionLabel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 06. 10..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class DescriptionLabel: UILabel {
    // MARK: Properties
    private let insets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)

    // MARK: View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }

    // MARK: Setup appearance
    private func setupAppearance() {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        text = ""
        backgroundColor = Theme.Color.descriptionLabelLightGray
        cornerRadius = 10
    }
}

// MARK: Overrides
extension DescriptionLabel {
    override func drawText(in rect: CGRect) {
        preferredMaxLayoutWidth = superview!.frame.width
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += insets.left + insets.right
        contentSize.height += insets.top + insets.bottom

        return contentSize
    }
}
