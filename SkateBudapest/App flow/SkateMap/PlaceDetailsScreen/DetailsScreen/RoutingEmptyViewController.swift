//
//  RoutingEmptyViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 11..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class RoutingEmptyViewController: UIViewController, StoryboardLoadable {
    // MARK: Outlets
    @IBOutlet weak var enableLocationLabel: UILabel!
    @IBOutlet weak var enableLocationButton: UIButton!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        addAccessibilityIDs()
        enableLocationLabel.text = Texts.LocationDetails.mapNavigationEmptyViewText.localized
        enableLocationLabel.textColor = Theme.Color.textDark
        enableLocationButton.setTitle(Texts.LocationDetails.mapNavigationEmptyViewButtonText.localized, for: .normal)
    }

    private func addAccessibilityIDs() {
        enableLocationLabel.accessibilityIdentifier = AccessibilityID.PlaceDetails.enableLocationLabel
        enableLocationButton.accessibilityIdentifier = AccessibilityID.PlaceDetails.enableLocationButton
    }

    // MARK: Actions
    @IBAction func enableLocationTap(_ sender: Any) {
        UIApplication.openSettings()
    }
}
