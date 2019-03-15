//
//  MainCoordinator.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 09..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

final class MainCoordinator: NSObject, UITabBarControllerDelegate {
    // MARK: Properties
    let tabBarController: UITabBarController
    let skateMapCoordinator: SkateMapCoordinator
    let submitPlaceCoordinator: SubmitPlaceCoordinator

    var rootViewController: UIViewController {
        return tabBarController
    }

    var childCoordinators: [Coordinator] {
        return [skateMapCoordinator, submitPlaceCoordinator]
    }

    // MARK: Initializers
    override init() {
        tabBarController = UITabBarController()
        skateMapCoordinator = SkateMapCoordinator(navigationController: UINavigationController())
        submitPlaceCoordinator = SubmitPlaceCoordinator(navigationController: UINavigationController())
        super.init()

        configureTabBarController()
    }
}

// MARK: Configuration
extension MainCoordinator {
    private func configureTabBarController() {
        let mapScreen = createMapScreen()
        skateMapCoordinator.configureTabBarItem(on: mapScreen)

        let submitScreen = createSubmitScreen()
        submitPlaceCoordinator.configureTabBarItem(on: submitScreen)

        tabBarController.viewControllers = [mapScreen, submitScreen]
        tabBarController.tabBar.isTranslucent = false
        tabBarController.delegate = self
    }
}

// MARK: Create ViewControllers for Tab Bar
extension MainCoordinator {
    private func createMapScreen() -> UINavigationController {
        return skateMapCoordinator.embedRootScreenInNavigationController()
    }

    private func createSubmitScreen() -> UINavigationController {
        return submitPlaceCoordinator.embedRootScreenInNavigationController()
    }
}
