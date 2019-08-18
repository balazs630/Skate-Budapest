//
//  AlertController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 08. 18..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class AlertController: UIAlertController {
    private lazy var alertWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ClearViewController()
        window.backgroundColor = .clear
        window.windowLevel = .alert

        return window
    }()

    func show(animated: Bool = true, completion: (() -> Void)? = nil) {
        if let rootViewController = alertWindow.rootViewController {
            alertWindow.makeKeyAndVisible()
            rootViewController.present(self, animated: animated, completion: completion)
        }
    }
}

private class ClearViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIApplication.shared.statusBarStyle
    }

    override var prefersStatusBarHidden: Bool {
        return UIApplication.shared.isStatusBarHidden
    }
}
