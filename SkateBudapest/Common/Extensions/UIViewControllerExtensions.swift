//
//  UIViewControllerExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 12..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController, to containerView: UIView, fillContainer: Bool = true) {
        if fillContainer {
            child.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            child.view.frame = containerView.bounds
        }

        containerView.addSubview(child.view)
        addChild(child)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    func addActivityIndicator(title: String) {
        add(LoadingViewController(title: title), to: view)
    }

    func removeActivityIndicator() {
        _ = view
            .subviews
            .filter { $0.parentViewController is LoadingViewController }
            .map { $0.removeFromSuperview() }
    }
}
