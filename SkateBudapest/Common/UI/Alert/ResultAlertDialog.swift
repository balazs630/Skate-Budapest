//
//  ResultAlertDialog.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 01..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class ResultAlertDialog: AlertController {
    convenience init(title: String?, message: String?) {
        self.init(title: title, message: message, preferredStyle: .alert)
        addDefaultAction()
    }

    private func addDefaultAction() {
        let action = UIAlertAction(title: Texts.General.ok.localized, style: .default)
        addAction(action)
    }
}
