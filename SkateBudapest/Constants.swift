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
    static let dataSourceGPXUrl = "https://libertyskate.hu/mobile/example/locations.gpx"
    //static let dataSourceGPXUrl = "https://libertyskate.hu/mobile/skate-budapest/locations.gpx"

    static let leftAccessoryViewSize = CGRect(x: 0, y: 0, width: 59, height: 59)
    static let calloutViewIdentifier = "calloutViewIdentifier"
}

public enum GPX {
    public enum Tag: String {
        case waypoint = "wpt"
        case latitude = "lat"
        case longitude = "lon"
        case name = "name"
        case description = "desc"
        case locationType = "loctype"
        case image = "img"
        case href = "href"
        case imageType = "imgtype"
        case smallImage = "thumbnail"
        case largeImage = "large"
    }
}

extension UserDefaults {
    struct Key {
        static let isAppAlreadyLaunchedOnce = "isAppAlreadyLaunchedOnce"
        static let appVersion = "appVersion"
    }
}
