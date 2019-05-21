//
//  AppDelegate.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpMainNavigator()
        initUserDefaults()
        enableKeyboardManager()

        return true
    }
}

// MARK: - Navigation setup
extension AppDelegate {
    func setUpMainNavigator() {
        coordinator = MainCoordinator()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator?.rootViewController
        window?.makeKeyAndVisible()
    }
}

// MARK: - UserDefaults setup
extension AppDelegate {
    private func initUserDefaults() {
        let defaults = UserDefaults.standard

        if defaults.object(forKey: UserDefaults.Key.isAppAlreadyLaunchedOnce) == nil {
            let firstTimeLaunchDefaults: [String: Any] = [
                UserDefaults.Key.isAppAlreadyLaunchedOnce: true,

                UserDefaults.Key.Switch.skatepark: true,
                UserDefaults.Key.Switch.skateshop: true,
                UserDefaults.Key.Switch.streetspot: true
            ]

            firstTimeLaunchDefaults.forEach {
                defaults.set($0.value, forKey: $0.key)
            }

            defaults.synchronize()
        }
    }
}

// MARK: - IQKeyboardManagerSwift pod methods
extension AppDelegate {
    private func enableKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }
}
