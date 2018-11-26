//
//  SubmitPlaceViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 15..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitPlaceViewController: UIViewController {
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        navigationItem.title = Texts.SendSpace.sendPlaceNavBarTitle.localized
    }
}
