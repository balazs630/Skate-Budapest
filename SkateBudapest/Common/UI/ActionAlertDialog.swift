//
//  ActionAlertDialog.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 05. 19..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class ActionAlertDialog {
    static func build(title: String, message: String, primaryAction: UIAlertAction) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: Texts.General.cancel.localized, style: .cancel, handler: nil)
        [primaryAction, cancelAction].forEach { alertController.addAction($0) }

        return alertController
    }
}
