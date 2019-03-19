//
//  UIResponderExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 20..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
