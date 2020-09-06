//
//  AlertController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 08. 18..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class AlertWindow: UIWindow { }

class AlertController: UIAlertController {
    private lazy var alertWindow: AlertWindow = {
        let window = AlertWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ClearViewController()
        window.backgroundColor = .clear
        window.windowLevel = .alert

        return window
    }()

    func show(animated: Bool = true, completion: (() -> Void)? = nil) {
        if !hasPresentedAlertWindow() {
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(self, animated: animated, completion: completion)
        }
    }

    private func hasPresentedAlertWindow() -> Bool {
        return UIApplication.shared.windows.contains(where: {
            $0.isKind(of: AlertWindow.self)
        })
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
