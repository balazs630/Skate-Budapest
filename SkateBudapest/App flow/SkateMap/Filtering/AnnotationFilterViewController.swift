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
    @IBOutlet weak var swSkatepark: UISwitch!
    @IBOutlet weak var swSkateshop: UISwitch!
    @IBOutlet weak var swStreetspot: UISwitch!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFilterPreferences()
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

    // MARK: Utility methods
    func selectedTypes() -> [LocationType] {
        var filteredTypes = [LocationType]()
        if swSkatepark.isOn {
            filteredTypes.append(LocationType.skatepark)
        }

        if swSkateshop.isOn {
            filteredTypes.append(LocationType.skateshop)
        }

        if swStreetspot.isOn {
            filteredTypes.append(LocationType.streetspot)
        }

        return filteredTypes
    }

    private func loadFilterPreferences() {
        swSkatepark.isOn = defaults.bool(forKey: UserDefaults.Key.Sw.skatepark)
        swSkateshop.isOn = defaults.bool(forKey: UserDefaults.Key.Sw.skateshop)
        swStreetspot.isOn = defaults.bool(forKey: UserDefaults.Key.Sw.streetspot)
    }

    private func saveFilterPreferences() {
        defaults.set(swSkatepark.isOn, forKey: UserDefaults.Key.Sw.skatepark)
        defaults.set(swSkateshop.isOn, forKey: UserDefaults.Key.Sw.skateshop)
        defaults.set(swStreetspot.isOn, forKey: UserDefaults.Key.Sw.streetspot)

        defaults.synchronize()
    }
}
