//
//  EmptyDataConfiguration.swift
//  SkateBudapest
//
//  Created by Balázs Horváth on 2020. 09. 12..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

struct EmptyDataConfiguration {
    let title: String
    let hasActionButton: Bool
    let buttonTitle: String
    let buttonAction: () -> Void

    init(title: String,
         hasActionButton: Bool = false,
         buttonTitle: String = "",
         buttonAction: @escaping () -> Void = { () }) {
        self.title = title
        self.hasActionButton = hasActionButton
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
}
