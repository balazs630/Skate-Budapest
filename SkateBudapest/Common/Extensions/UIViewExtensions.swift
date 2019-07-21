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
        subviews.forEach { self.addSubview($0) }
    }

    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
}
