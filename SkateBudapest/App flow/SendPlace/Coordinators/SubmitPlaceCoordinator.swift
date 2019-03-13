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
        toSubmitPlaceTypeSelectorScreen()
        return navigationController
    }
}

// MARK: Navigation
extension SubmitPlaceCoordinator {
    func toSubmitPlaceTypeSelectorScreen() {
        let submitPlaceTypeScreen = SubmitTypeSelectorViewController.instantiateViewController(from: .submitPlace)
        submitPlaceTypeScreen.coordinator = self
        navigationController.pushViewController(submitPlaceTypeScreen, animated: true)
    }

    func toSubmitTextsScreen() {
        let submitTextualScreen = SubmitTextsViewController.instantiateViewController(from: .submitPlace)
        submitTextualScreen.coordinator = self
        navigationController.pushViewController(submitTextualScreen, animated: true)
    }

    func toSubmitImagesScreen() {
        let submitImagesScreen = SubmitImagesViewController.instantiateViewController(from: .submitPlace)
        submitImagesScreen.coordinator = self
        navigationController.pushViewController(submitImagesScreen, animated: true)
    }

    func toSubmitPositionScreen() {
        let sumitPositionScreen = SubmitPositionViewController.instantiateViewController(from: .submitPlace)
        sumitPositionScreen.coordinator = self
        navigationController.pushViewController(sumitPositionScreen, animated: true)
    }

    func toSubmitSummaryScreen() {
        let submitSummaryScreen = SubmitSummaryViewController.instantiateViewController(from: .submitPlace)
        submitSummaryScreen.coordinator = self
        navigationController.pushViewController(submitSummaryScreen, animated: true)
    }
}
