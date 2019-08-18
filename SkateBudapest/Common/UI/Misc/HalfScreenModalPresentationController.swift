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
        let modalViewHeight = CGFloat(360)
        let calculatedViewHeight = modalViewHeight + UIApplication.SafeAreaInset.bottom

        return CGRect(x: 0,
                      y: containerView!.bounds.height - calculatedViewHeight,
                      width: containerView!.bounds.width,
                      height: calculatedViewHeight)
    }
}
