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

class PlaceFilterViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var delegate: PlaceFilterDelegate?
    var placeFilterController = PlaceFilterController()

    // MARK: Outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var skateparkSwitch: UISwitch!
    @IBOutlet weak var skateshopSwitch: UISwitch!
    @IBOutlet weak var streetspotSwitch: UISwitch!

    @IBOutlet weak var skateshopLabel: UILabel!
    @IBOutlet weak var streetspotLabel: UILabel!
    @IBOutlet weak var skateparkLabel: UILabel!

    @IBOutlet weak var filterButton: Button!

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
        dismiss(animated: true, completion: nil)
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
