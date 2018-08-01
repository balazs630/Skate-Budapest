//
//  LocationDetailsViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {
    // Properties
    var waypoint: Waypoint!

    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - Screen configuration
    private func configureView() {
        titleLabel.text = waypoint.name
        descriptionLabel.text = waypoint.info
    }
}
