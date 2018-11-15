//
//  AnnotationFilterViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 26..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

protocol AnnotationFilterDelegate: class {
    func filterAnnotationsBy(types: [LocationType])
}

class AnnotationFilterViewController: UIViewController {
    // MARK: Properties
    let defaults = UserDefaults.standard
    weak var delegate: AnnotationFilterDelegate?

    // MARK: Outlets
    @IBOutlet weak var skateparkSwitch: UISwitch!
    @IBOutlet weak var skateshopSwitch: UISwitch!
    @IBOutlet weak var streetspotSwitch: UISwitch!

    @IBOutlet weak var filterLabel: UIButton!
    @IBOutlet weak var closeLabel: UIButton!

    @IBOutlet weak var skateshopLabel: UILabel!
    @IBOutlet weak var streetspotLabel: UILabel!
    @IBOutlet weak var skateparkLabel: UILabel!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        loadFilterPreferences()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        filterLabel.setTitle(Texts.SkateMap.filteringFilter.localized, for: .normal)
        closeLabel.setTitle(Texts.SkateMap.filteringClose.localized, for: .normal)

        skateshopLabel.text = Texts.SkateMap.filterTypeSkateshop.localized
        streetspotLabel.text = Texts.SkateMap.filterTypeSkatespot.localized
        skateparkLabel.text = Texts.SkateMap.filterTypeSkatepark.localized
    }

    // MARK: Button actions
    @IBAction func closeButtonTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func filterButtonTap(_ sender: Any) {
        delegate?.filterAnnotationsBy(types: selectedTypes())
        saveFilterPreferences()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: Utility methods
extension AnnotationFilterViewController {
    private func selectedTypes() -> [LocationType] {
        var filteredTypes = [LocationType]()
        if skateparkSwitch.isOn {
            filteredTypes.append(LocationType.skatepark)
        }

        if skateshopSwitch.isOn {
            filteredTypes.append(LocationType.skateshop)
        }

        if streetspotSwitch.isOn {
            filteredTypes.append(LocationType.streetspot)
        }

        return filteredTypes
    }

    private func loadFilterPreferences() {
        skateparkSwitch.isOn = defaults.bool(forKey: UserDefaults.Key.Sw.skatepark)
        skateshopSwitch.isOn = defaults.bool(forKey: UserDefaults.Key.Sw.skateshop)
        streetspotSwitch.isOn = defaults.bool(forKey: UserDefaults.Key.Sw.streetspot)
    }

    private func saveFilterPreferences() {
        defaults.set(skateparkSwitch.isOn, forKey: UserDefaults.Key.Sw.skatepark)
        defaults.set(skateshopSwitch.isOn, forKey: UserDefaults.Key.Sw.skateshop)
        defaults.set(streetspotSwitch.isOn, forKey: UserDefaults.Key.Sw.streetspot)

        defaults.synchronize()
    }
}
