//
//  Constants.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

struct Constant {
    static let shortVersionString = "CFBundleShortVersionString"
    static let dataSourceGPXUrl = "http://libertyskate.hu/mobile/skate-budapest-locations.gpx"
}

extension UserDefaults {
    struct Key {
        static let isAppAlreadyLaunchedOnce = "isAppAlreadyLaunchedOnce"
        static let appVersion = "appVersion"
    }
}
