//
//  Coordinator.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 09..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    init(navigationController: UINavigationController)

    func embedRootScreenInNavigationController() -> UINavigationController
    func firstViewController<T: UIViewController>() -> T?
}

extension Coordinator {
    func firstViewController<T: UIViewController>() -> T? {
        return navigationController
            .viewControllers
            .filter { $0 is T }
            .compactMap { $0 as? T }
            .first
    }
}
