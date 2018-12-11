//
//  ApiEnvironment.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 11..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

enum ApiEnvironment: String {
    case production = "https://skate-budapest.vapor.cloud"

    var url: String {
        return rawValue
    }
}
