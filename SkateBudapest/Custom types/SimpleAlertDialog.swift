//
//  SimpleAlertDialog.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class SimpleAlertDialog {
    static func build(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alertController.addAction(defaultAction)

        return alertController
    }
}
