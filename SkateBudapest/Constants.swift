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
    static let dataSourceGPXUrl = URL(string: "https://libertyskate.hu/mobile/example/locations.gpx")!
    //static let dataSourceGPXUrl = URL(string: "https://libertyskate.hu/mobile/skate-budapest/locations.gpx")!

    static let calloutImageViewSize = CGRect(x: 0, y: 0, width: 59, height: 59)
    static let calloutViewIdentifier = "mapPinPopupView"
}

public enum Theme {
    public enum Icons {
        public static let skateparkPin = "yellow"
        public static let skateshopPin = "green"
        public static let streetSpotPin = "purple"
    }
}

public enum GPX {
    public enum Tag: String {
        case waypoint = "wpt"
        case latitude = "lat"
        case longitude = "lon"
        case name
        case description = "desc"
        case locationType = "loctype"
        case image = "img"
        case href
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

struct SegueIdentifier {
    static let showLocationPinDetails = "showLocationPinDetailsSegue"
}
