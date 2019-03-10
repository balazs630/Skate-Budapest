//
//  SubmitTypeSelectorViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 15..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitTypeSelectorViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var coordinator: SubmitPlaceCoordinator?

    // MARK: Outlets

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        title = "Type selector"
        navigationController?.navigationBar.barTintColor = Theme.Color.primaryTurquoise
    }

    // MARK: Actions
    @IBAction func skateParkTypeTap(_ sender: Any) {
        Master.type = "skatepark"
    }

    @IBAction func streetSpotTypeTap(_ sender: Any) {
        Master.type = "streetspot"
    }

    @IBAction func skateshopTypeTap(_ sender: Any) {
        Master.type = "skateshop"
    }
}

public struct Master {
    static var type: String!
    static var title: String!
    static var info: String!
}
