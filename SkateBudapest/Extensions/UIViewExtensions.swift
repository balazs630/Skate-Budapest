//
//  UIViewExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 02..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ self.addSubview($0) })
    }
}
