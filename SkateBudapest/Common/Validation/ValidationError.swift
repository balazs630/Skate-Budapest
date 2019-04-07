//
//  ValidationError.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

class ValidationError: BaseError {
    let title: String
    let message: String

    init(title: String = "", message: String = "") {
        self.title = title
        self.message = message
    }
}
