//
//  StoryboardLoadable.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 09..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

// swiftlint:disable next identifier_name force_cast

import UIKit

protocol StoryboardLoadable {
    static func instantiateViewController(from storyboardName: StoryboardName) -> Self
}

extension StoryboardLoadable where Self: UIViewController {
    static func instantiateViewController(from storyboardName: StoryboardName) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
