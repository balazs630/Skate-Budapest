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

        let viewControllers: [UIViewController] = [makeMapScreen(), makeSubmitScreen()]
        tabBarController.viewControllers = viewControllers
        tabBarController.tabBar.isTranslucent = false
        tabBarController.delegate = self
    }
}

// MARK: Create ViewControllers for tab bar
extension MainCoordinator {
    private func makeMapScreen() -> UINavigationController {
        let skateMapNavigationController = skateMapCoordinator.embedRootInNavigationController()
        skateMapNavigationController.tabBarItem = UITabBarItem(title: Texts.SkateMap.mapTabBarTitle.localized,
                                                               image: Theme.Icon.mapIcon,
                                                               selectedImage: Theme.Icon.mapIcon)
        return skateMapNavigationController
    }

    private func makeSubmitScreen() -> UINavigationController {
        let submitPlaceNavigationController = submitPlaceCoordinator.embedRootInNavigationController()
        submitPlaceNavigationController.tabBarItem = UITabBarItem(title: Texts.SendSpace.sendPlaceTabBarTitle.localized,
                                                                  image: Theme.Icon.addPinIcon,
                                                                  selectedImage: Theme.Icon.addPinIcon)
        return submitPlaceNavigationController
    }
}
