//
//  TextView.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 06. 12..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class TextView: UITextView {
    // MARK: View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }

    // MARK: Setup appearance
    private func setupAppearance() {
        layer.cornerRadius = 5
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 0.5
    }
}
