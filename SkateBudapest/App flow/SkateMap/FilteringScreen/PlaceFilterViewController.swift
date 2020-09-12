//
//  PlaceFilterViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 26..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

protocol PlaceFilterDelegate: class {
    func filterAnnotations(by selectedTypes: [WaypointType])
}

class PlaceFilterViewController: UIViewController {
    // MARK: Properties
    weak var delegate: PlaceFilterDelegate?
    private var placeFilterController = PlaceFilterController()

    // MARK: Outlets
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var skateparkLabel: UILabel!
    @IBOutlet private weak var skateparkSwitch: UISwitch!

    @IBOutlet private weak var streetspotLabel: UILabel!
    @IBOutlet private weak var streetspotSwitch: UISwitch!

    @IBOutlet private weak var skateshopLabel: UILabel!
    @IBOutlet private weak var skateshopSwitch: UISwitch!

    @IBOutlet private weak var filterButton: Button!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        applyFilteringPreferences()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        headerView.backgroundColor = Theme.Color.primaryTurquoise
        titleLabel.text = Texts.SkateMap.filterScreenTitle.localized

        skateshopLabel.text = Texts.SkateMap.skateshopType.localized
        streetspotLabel.text = Texts.SkateMap.streetspotType.localized
        skateparkLabel.text = Texts.SkateMap.skateparkType.localized

        filterButton.style = .action
        filterButton.setTitle(Texts.SkateMap.filterButtonTitle.localized, for: .normal)
    }

    // MARK: Button actions
    @IBAction func filterButtonTap(_ sender: Any) {
        persistFilteringPreferences()
        delegate?.filterAnnotations(by: placeFilterController.selectedTypes())
        dismiss(animated: true)
    }

    // MARK: Load/save switch states
    private func applyFilteringPreferences() {
        let preferences = placeFilterController.loadFilterPreferences()
        skateparkSwitch.isOn = preferences.isSkatepark
        skateshopSwitch.isOn = preferences.isSkateshop
        streetspotSwitch.isOn = preferences.isStreetspot
    }

    private func persistFilteringPreferences() {
        placeFilterController.saveFilterPreferences(
            PlaceFilterPreference(isSkatepark: skateparkSwitch.isOn,
                                  isSkateshop: skateshopSwitch.isOn,
                                  isStreetspot: streetspotSwitch.isOn)
        )
    }

    // MARK: Gesture recognizer actions
    @IBAction func didDragView(_ sender: UIPanGestureRecognizer) {
        dismiss(animated: true)
    }
}
