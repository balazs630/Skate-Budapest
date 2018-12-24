//
//  UIViewControllerExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 26..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIViewController {
    func configureTabBarTexts(with titles: [String]) {
        tabBarController?.tabBar.items?.enumerated().forEach { (index, element) in
            if titles.indices.contains(index) {
                element.title = titles[index]
            }
        }
    }
}
