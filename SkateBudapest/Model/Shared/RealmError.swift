//
//  RealmError.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 11..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

class RealmError: BaseError {
    let title: String
    let message: String

    init(title: String = Texts.RealmError.defaultTitle.localized, message: String) {
        self.title = title
        self.message = message
    }
}
