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
}

// MARK: Configuration
extension SubmitPlaceCoordinator {
    func embedRootScreenInNavigationController() -> UINavigationController {
        toSubmitPlaceDescriptionScreen()
        return navigationController
    }

    func configureTabBarItem(on viewController: UINavigationController) {
        viewController.tabBarItem = UITabBarItem(title: Texts.SubmitPlace.submit.localized,
                                                 image: Theme.Icon.addPinIcon,
                                                 selectedImage: Theme.Icon.addPinIcon)
        viewController.tabBarItem.accessibilityIdentifier = AccessibilityID.SkateMap.submitTabBar
    }
}

// MARK: Navigation
extension SubmitPlaceCoordinator {
    func toSubmitPlaceDescriptionScreen() {
        let submitDescriptionScreen = SubmitPlaceDescriptionViewController.instantiateViewController(from: .submitPlace)
        submitDescriptionScreen.coordinator = self

        navigationController.pushViewController(submitDescriptionScreen, animated: true)
    }

    func toSubmitPlaceTypeSelectorScreen() {
        let submitPlaceTypeScreen = SubmitTypeSelectorViewController.instantiateViewController(from: .submitPlace)
        submitPlaceTypeScreen.coordinator = self
        submitPlaceTypeScreen.placeSuggestionDisplayItem = PlaceSuggestionDisplayItem(
            coordinate: Constant.defaultCityCoordinate
        )

        navigationController.pushViewController(submitPlaceTypeScreen, animated: true)
    }

    func toSubmitTextsScreen(with placeSuggestion: PlaceSuggestionDisplayItem?) {
        let submitTextualScreen = SubmitTextsViewController.instantiateViewController(from: .submitPlace)
        submitTextualScreen.coordinator = self
        submitTextualScreen.placeSuggestionDisplayItem = placeSuggestion

        navigationController.pushViewController(submitTextualScreen, animated: true)
    }

    func toSubmitImagesScreen(with placeSuggestion: PlaceSuggestionDisplayItem?) {
        let submitImagesScreen = SubmitImagesViewController.instantiateViewController(from: .submitPlace)
        submitImagesScreen.coordinator = self
        submitImagesScreen.placeSuggestionDisplayItem = placeSuggestion

        navigationController.pushViewController(submitImagesScreen, animated: true)
    }

    func toSubmitPositionScreen(with placeSuggestion: PlaceSuggestionDisplayItem?) {
        let sumitPositionScreen = SubmitPositionViewController.instantiateViewController(from: .submitPlace)
        sumitPositionScreen.coordinator = self
        sumitPositionScreen.placeSuggestionDisplayItem = placeSuggestion

        navigationController.pushViewController(sumitPositionScreen, animated: true)
    }

    func toSubmitSummaryScreen() {
        let submitSummaryScreen = SubmitResultViewController.instantiateViewController(from: .submitPlace)
        submitSummaryScreen.coordinator = self

        navigationController.pushViewController(submitSummaryScreen, animated: true)
    }
}

// MARK: Back navigation actions
extension SubmitPlaceCoordinator {
    func backToSubmitTypeSelectorScreen(with placeSuggestion: PlaceSuggestionDisplayItem?) {
        let previousScreen: SubmitTypeSelectorViewController? = firstViewController()
        previousScreen?.placeSuggestionDisplayItem = placeSuggestion
        previousScreen?.configureVideoViews()
    }

    func backToSubmitTextsScreen(with placeSuggestion: PlaceSuggestionDisplayItem?) {
        let previousScreen: SubmitTextsViewController? = firstViewController()
        previousScreen?.placeSuggestionDisplayItem = placeSuggestion
    }

    func backToImagesScreen(with placeSuggestion: PlaceSuggestionDisplayItem?) {
        let previousScreen: SubmitImagesViewController? = firstViewController()
        previousScreen?.placeSuggestionDisplayItem = placeSuggestion
    }
}
