//
//  DoubleExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 13..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Foundation

extension Double {
    var data: Data {
        guard let data = String(describing: self).data(using: .utf8) else {
            return Data()
        }

        return data
    }
}
