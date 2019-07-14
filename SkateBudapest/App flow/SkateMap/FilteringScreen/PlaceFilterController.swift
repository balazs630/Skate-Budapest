//
//  PlaceFilterController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 07. 14..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Foundation

class PlaceFilterController {
    // MARK: Properties
    private let defaults = UserDefaults.standard

    // MARK: Utility methods
    func visibility(for place: PlaceDisplayItem) -> Bool {
        return selectedTypes().contains(place.type) ? true : false
    }

    func selectedTypes() -> [WaypointType] {
        let filterPreferences = loadFilterPreferences()
        var filteredTypes = [WaypointType]()

        if filterPreferences.isSkatepark { filteredTypes.append(.skatepark) }
        if filterPreferences.isSkateshop { filteredTypes.append(.skateshop) }
        if filterPreferences.isStreetspot { filteredTypes.append(.streetspot) }

        return filteredTypes
    }

    func loadFilterPreferences() -> PlaceFilterPreference {
        return PlaceFilterPreference(isSkatepark: defaults.bool(forKey: UserDefaults.Key.Switch.skatepark),
                                     isSkateshop: defaults.bool(forKey: UserDefaults.Key.Switch.skateshop),
                                     isStreetspot: defaults.bool(forKey: UserDefaults.Key.Switch.streetspot))
    }

    func saveFilterPreferences(_ preferences: PlaceFilterPreference) {
        defaults.set(preferences.isSkatepark, forKey: UserDefaults.Key.Switch.skatepark)
        defaults.set(preferences.isSkateshop, forKey: UserDefaults.Key.Switch.skateshop)
        defaults.set(preferences.isStreetspot, forKey: UserDefaults.Key.Switch.streetspot)

        defaults.synchronize()
    }
}
