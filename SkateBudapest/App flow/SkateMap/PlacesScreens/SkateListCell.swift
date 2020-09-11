//
//  SkateListCell.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 07. 08..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SkateListCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!

    // MARK: Properties
    var displayItem: PlaceDisplayItem? {
        didSet {
            setupLabels()
            setupImage()
        }
    }

    // MARK: View lifycycle
    override func awakeFromNib() {
        super.awakeFromNib()
        addAccessibilityIDs()
    }
}

// MARK: Setup view
extension SkateListCell {
    private func setupLabels() {
        titleLabel.text = displayItem?.name
        descriptionLabel.text = displayItem?.info
    }

    private func setupImage() {
        guard let imageData = displayItem?.thumbnailImageData else { return }
        thumbnailImageView.image = UIImage(data: imageData)
    }

    private func addAccessibilityIDs() {
        accessibilityIdentifier = AccessibilityID.SkateMap.listCellContainerView

        titleLabel.accessibilityIdentifier = AccessibilityID.SkateMap.listCellTitleLabel
        descriptionLabel.accessibilityIdentifier = AccessibilityID.SkateMap.listCellDescriptionLabel
        thumbnailImageView.accessibilityIdentifier = AccessibilityID.SkateMap.listCallThumbnailImage
    }
}
