//
//  ImageViewPicker.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 06. 26..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class ImageViewPicker: UIImageView {
    // MARK: Properties
    private lazy var placeHolderImage = UIImageView()
    public var showPlaceHolder: Bool {
        get {
            return !placeHolderImage.isHidden
        }
        set(newValue) {
            placeHolderImage.isHidden = !newValue
        }
    }

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: Setup appearance
    private func commonInit() {
        backgroundColor = .clear
        configurePlaceHolderImage()
    }

    private func configurePlaceHolderImage() {
        placeHolderImage.isUserInteractionEnabled = false
        placeHolderImage.contentMode = .scaleAspectFit
        placeHolderImage.image = Theme.Image.addImagePlaceholder

        addSubview(placeHolderImage)
        placeHolderImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeHolderImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            placeHolderImage.topAnchor.constraint(equalTo: topAnchor),
            placeHolderImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            placeHolderImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
