//
//  HalfScreenModalPresentationController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 08. 26..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class HalfScreenModalPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0,
                      y: containerView!.bounds.height / 2,
                      width: containerView!.bounds.width,
                      height: containerView!.bounds.height / 2)
    }
}
