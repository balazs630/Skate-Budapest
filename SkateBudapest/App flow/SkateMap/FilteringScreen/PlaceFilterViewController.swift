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
    private let defaults = UserDefaults.standard
    weak var delegate: PlaceFilterDelegate?

    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var skateparkSwitch: UISwitch!
    @IBOutlet weak var skateshopSwitch: UISwitch!
    @IBOutlet weak var streetspotSwitch: UISwitch!

    @IBOutlet weak var skateshopLabel: UILabel!
    @IBOutlet weak var streetspotLabel: UILabel!
    @IBOutlet weak var skateparkLabel: UILabel!

    @IBOutlet weak var filterButton: UIButton!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        addGestureRecognizers()
        loadFilterPreferences()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        titleLabel.text = Texts.SkateMap.filterScreenTitle.localized

        skateshopLabel.text = Texts.SkateMap.skateshopType.localized
        streetspotLabel.text = Texts.SkateMap.streetspotType.localized
        skateparkLabel.text = Texts.SkateMap.skateparkType.localized

        filterButton.setTitle(Texts.SkateMap.filterButtonTitle.localized, for: .normal)
    }

    private func addGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(panGestureRecognizerHandler(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }

    // MARK: Button actions
    @IBAction func filterButtonTap(_ sender: Any) {
        delegate?.filterAnnotations(by: selectedTypes())
        saveFilterPreferences()
        dismiss(animated: true, completion: nil)
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
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height)
                })
            }
        case .failed, .possible:
            break
        @unknown default:
            break
        }
    }
}

// MARK: Utility methods
extension PlaceFilterViewController {
    private func selectedTypes() -> [WaypointType] {
        var filteredTypes = [WaypointType]()
        if skateparkSwitch.isOn { filteredTypes.append(WaypointType.skatepark) }
        if skateshopSwitch.isOn { filteredTypes.append(WaypointType.skateshop) }
        if streetspotSwitch.isOn { filteredTypes.append(WaypointType.streetspot) }

        return filteredTypes
    }

    private func loadFilterPreferences() {
        skateparkSwitch.isOn = defaults.bool(forKey: UserDefaults.Key.Switch.skatepark)
        skateshopSwitch.isOn = defaults.bool(forKey: UserDefaults.Key.Switch.skateshop)
        streetspotSwitch.isOn = defaults.bool(forKey: UserDefaults.Key.Switch.streetspot)
    }

    private func saveFilterPreferences() {
        defaults.set(skateparkSwitch.isOn, forKey: UserDefaults.Key.Switch.skatepark)
        defaults.set(skateshopSwitch.isOn, forKey: UserDefaults.Key.Switch.skateshop)
        defaults.set(streetspotSwitch.isOn, forKey: UserDefaults.Key.Switch.streetspot)

        defaults.synchronize()
    }
}
