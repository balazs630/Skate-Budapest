//
//  UpdateService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

final class UpdateService {
}

// MARK: Utility methods
extension UpdateService {
    class func syncCurrentAppVersion() {
        let defaults = UserDefaults.standard
        defaults.set(getCurrentAppVersion(), forKey: UserDefaults.Key.appVersion)
        defaults.synchronize()
    }

    class func isAppVersionChangedSinceLastLaunch() -> Bool {
        return getCurrentAppVersion() != getLastAppVersion()
    }

    class func getCurrentAppVersion() -> String {
        guard let currentVersion = Bundle.main.infoDictionary?[Constant.shortVersionString] as? String else {
            return "1.0"
        }

        return currentVersion
    }

    class func getLastAppVersion() -> String {
        guard let lastVersion = UserDefaults.standard.string(forKey: UserDefaults.Key.appVersion) else {
            return "1.0"
        }

        return lastVersion
    }
}
