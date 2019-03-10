//
//  SubmitPositionViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitPositionViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var coordinator: SubmitPlaceCoordinator?

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        title = "Map"
    }
}
