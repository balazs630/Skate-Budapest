//
//  ActionAlertDialog.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 05. 19..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class ActionAlertDialog: AlertController {
    convenience init(title: String?,
                     message: String?,
                     primaryAction: UIAlertAction,
                     cancelAction: UIAlertAction? = nil) {
        self.init(title: title, message: message, preferredStyle: .alert)
        build(primaryAction: primaryAction, cancelAction: cancelAction)
    }

    private func build(primaryAction: UIAlertAction, cancelAction: UIAlertAction? = nil) {
        addAction(primaryAction)

        if let cancelAction = cancelAction {
            addAction(cancelAction)
        } else {
            let defaultCancelAction = UIAlertAction(title: Texts.General.cancel.localized, style: .cancel)
            addAction(defaultCancelAction)
        }
    }
}
