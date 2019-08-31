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
        addGestureRecognizers()
        applyFilteringPreferences()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        addAccessibilityIDs()

        headerView.backgroundColor = Theme.Color.primaryTurquoise
        titleLabel.text = Texts.SkateMap.filterScreenTitle.localized

        skateshopLabel.text = Texts.SkateMap.skateshopType.localized
        streetspotLabel.text = Texts.SkateMap.streetspotType.localized
        skateparkLabel.text = Texts.SkateMap.skateparkType.localized

        filterButton.style = .action
        filterButton.setTitle(Texts.SkateMap.filterButtonTitle.localized, for: .normal)
    }

    private func addAccessibilityIDs() {
        titleLabel.accessibilityIdentifier = AccessibilityID.Filter.titleLabel

        skateshopLabel.accessibilityIdentifier = AccessibilityID.Filter.skateshopLabel
        skateshopSwitch.accessibilityIdentifier = AccessibilityID.Filter.skateshopSwitch

        streetspotLabel.accessibilityIdentifier = AccessibilityID.Filter.streetspotLabel
        streetspotSwitch.accessibilityIdentifier = AccessibilityID.Filter.streetspotSwitch

        skateparkLabel.accessibilityIdentifier = AccessibilityID.Filter.skateparkLabel
        skateparkSwitch.accessibilityIdentifier = AccessibilityID.Filter.skateparkSwitch

        filterButton.accessibilityIdentifier = AccessibilityID.Filter.actionButton
    }

    private func addGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(panGestureRecognizerHandler(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
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
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: view?.window)
        var initialTouchPoint = CGPoint.zero

        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            if touchPoint.y > initialTouchPoint.y {
                view.frame.origin.y = touchPoint.y - initialTouchPoint.y
                if view.frame.origin.y < view.frame.height {
                    dismiss(animated: true, completion: nil)
                }
            }
        case .ended, .cancelled:
            if touchPoint.y - initialTouchPoint.y > 200 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height)
                }
            }
        case .failed, .possible:
            break
        @unknown default:
            break
        }
    }
}
