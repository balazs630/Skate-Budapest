//
//  SkateMapNavigator.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 09..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SkateMapCoordinator: Coordinator {
    // MARK: Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: Initializers
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: Configuration
extension SkateMapCoordinator {
    func embedRootScreenInNavigationController() -> UINavigationController {
        toSkateMapContainerScreen()
        return navigationController
    }

    func configureTabBarItem(on viewController: UINavigationController) {
        viewController.tabBarItem = UITabBarItem(title: Texts.SkateMap.mapTabBarTitle.localized,
                                                 image: Theme.Icon.mapIcon,
                                                 selectedImage: Theme.Icon.mapIcon)
        viewController.tabBarItem.accessibilityIdentifier = AccessibilityID.SkateMap.mapTabBar
    }
}

// MARK: Navigation
extension SkateMapCoordinator {
    func toSkateMapContainerScreen() {
        let skateMapContainerScreen = SkateMapContainerViewController.instantiateViewController(from: .skateMap)
        skateMapContainerScreen.coordinator = self
        navigationController.pushViewController(skateMapContainerScreen, animated: true)
    }

    func toFilteringScreen(from sourceViewController: SkateMapContainerViewController) {
        let filteringScreen = PlaceFilterViewController.instantiateViewController(from: .skateMap)

        filteringScreen.modalPresentationStyle = .overFullScreen
        filteringScreen.delegate = sourceViewController

        navigationController.present(filteringScreen, animated: true)
    }

    func toPlaceDetailsScreen(place: PlaceDisplayItem) {
        let placeDetailsScreen = PlaceDetailsViewController.instantiateViewController(from: .placeDetails)
        placeDetailsScreen.coordinator = self
        placeDetailsScreen.place = place

        navigationController.pushViewController(placeDetailsScreen, animated: true)
    }

    func toImageViewerScreen(from sourceViewController: PlaceDetailsViewController) {
        let imageViewerScreen = ImageViewerViewController.instantiateViewController(from: .placeDetails)
        imageViewerScreen.images = sourceViewController.imageViews?.images()
        imageViewerScreen.imageOffset = sourceViewController.imageOffset
        imageViewerScreen.delegate = sourceViewController

        navigationController.pushViewController(imageViewerScreen, animated: true)
    }

    func toReportingScreen(place: PlaceDisplayItem) {
        let reportingScreen = PlaceReportingViewController.instantiateViewController(from: .placeDetails)
        reportingScreen.place = place
        navigationController.present(reportingScreen, animated: true)
    }
}

// MARK: Back navigation actions
extension SkateMapCoordinator {
    func backToSkateMapScreen() {
        let previousScreen: SkateMapContainerViewController? = firstViewController()
        previousScreen?.navigationController?.navigationBar.barTintColor = Theme.Color.primaryTurquoise
    }
}
