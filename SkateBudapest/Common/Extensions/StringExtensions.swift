//
//  StringExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 21..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

extension String {
    var data: Data {
        guard let data = self.data(using: .utf8) else {
            return Data()
        }

        return data
    }

    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "", comment: "")
    }
}
