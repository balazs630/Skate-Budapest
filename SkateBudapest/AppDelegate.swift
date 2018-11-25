//
//  AppDelegate.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initUserDefaults()
        return true
    }
}

// MARK: - UserDefaults setup
extension AppDelegate {
    private func initUserDefaults() {
        let defaults = UserDefaults.standard

        if defaults.object(forKey: UserDefaults.Key.isAppAlreadyLaunchedOnce) == nil {
            let firstTimeLaunchDefaults: [String: Any] = [
                UserDefaults.Key.isAppAlreadyLaunchedOnce: true,

                UserDefaults.Key.Sw.skatepark: true,
                UserDefaults.Key.Sw.skateshop: true,
                UserDefaults.Key.Sw.streetspot: true
            ]

            firstTimeLaunchDefaults.forEach {
                defaults.set($0.value, forKey: $0.key)
            }

            defaults.synchronize()
        }
    }
}
