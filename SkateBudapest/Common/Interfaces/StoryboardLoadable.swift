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

        // swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
