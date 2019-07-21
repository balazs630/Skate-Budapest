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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!

    // MARK: Properties
    var displayItem: PlaceDisplayItem? {
        didSet {
            setupLabels()
            setupImage()
        }
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
}
