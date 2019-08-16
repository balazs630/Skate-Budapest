//
//  ActionAlertDialog.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 05. 19..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class ActionAlertDialog {
    static func build(title: String = "",
                      message: String = "",
                      primaryAction: UIAlertAction,
                      cancelAction: UIAlertAction? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        alertController.addAction(primaryAction)
        if let cancelAction = cancelAction {
            alertController.addAction(cancelAction)
        } else {
            let defaultCancelAction = UIAlertAction(title: Texts.General.cancel.localized, style: .cancel, handler: nil)
            alertController.addAction(defaultCancelAction)
        }

        return alertController
    }
}
