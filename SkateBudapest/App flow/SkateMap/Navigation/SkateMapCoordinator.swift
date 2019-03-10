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

    // MARK: Setup root ViewController
    func embedRootInNavigationController() -> UINavigationController {
        let rootViewController = SkateMapViewController.instantiateViewController(from: .skateMap)
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)

        return navigationController
    }
}

// MARK: Navigation
extension SkateMapCoordinator {
    func toFilteringScreen(using sourceViewController: SkateMapViewController) {
        let filteringViewController = PlaceFilterViewController.instantiateViewController(from: .skateMap)

        filteringViewController.modalPresentationStyle = .custom
        filteringViewController.view.frame.size.width = sourceViewController.view.frame.width
        filteringViewController.transitioningDelegate = sourceViewController
        filteringViewController.delegate = sourceViewController

        navigationController.present(filteringViewController, animated: true, completion: nil)
    }

    func toPlaceDetailsScreen(place: PlaceDisplayItem) {
        let placeDetails = PlaceDetailsViewController.instantiateViewController(from: .placeDetails)
        placeDetails.coordinator = self
        placeDetails.waypoint = place

        navigationController.pushViewController(placeDetails, animated: true)
    }

    func toImageViewerScreen(using sourceViewController: PlaceDetailsViewController) {
        let imageViewController = ImageViewerViewController.instantiateViewController(from: .placeDetails)
        imageViewController.images = sourceViewController.imageViews?.images()
        imageViewController.imageOffset = sourceViewController.imageOffset
        imageViewController.delegate = sourceViewController

        navigationController.pushViewController(imageViewController, animated: true)
    }
}
