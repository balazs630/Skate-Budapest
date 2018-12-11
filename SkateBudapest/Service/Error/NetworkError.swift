//
//  NetworkError.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 11..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

class NetworkError: BaseError {
    let title: String
    let message: String

    var localizedDescription: String {
        return message.localized
    }

    var localisedTitle: String {
        return title.localized
    }

    init(title: String = Texts.NetworkError.title, message: String) {
        self.title = title
        self.message = message
    }
}
