//
//  StoryboardLoadable.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 09..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

protocol StoryboardLoadable {
    static func instantiateViewController(from storyboardName: StoryboardName) -> Self
}

extension StoryboardLoadable where Self: UIViewController {
    static func instantiateViewController(from storyboardName: StoryboardName) -> Self {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: Bundle.main)

        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Storyboard '\(storyboardName)' doesn't contain a ViewController with identifier: \(identifier)")
        }

        return viewController
    }
}
