//
//  SubmitPlaceCoordinator.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 09..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitPlaceCoordinator: Coordinator {
    // MARK: Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: Initializers
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Setup root ViewController
    func embedRootInNavigationController() -> UINavigationController {
        let rootViewController = SubmitTypeSelectorViewController.instantiateViewController(from: .submitPlace)
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)

        return navigationController
    }
}

// MARK: Navigation
extension SubmitPlaceCoordinator {
    func toSubmitPlaceTypeSelectorScreen() { }

    func toSubmitTextsScreen() { }

    func toSubmitImagesScreen() { }

    func toSubmitPositionScreen() { }

    func toSubmitSummaryScreen() { }
}
