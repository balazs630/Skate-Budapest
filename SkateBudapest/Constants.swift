//
//  Constants.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//
// swiftlint:disable identifier_name

import UIKit

struct Constant {
    static let shortVersionString = "CFBundleShortVersionString"
    static let dataSourceGPXUrl = URL(string: "https://libertyskate.hu/mobile/example/locations.gpx")!
    //static let dataSourceGPXUrl = URL(string: "https://libertyskate.hu/mobile/skate-budapest/locations.gpx")!

    static let calloutImageViewSize = CGRect(x: 0, y: 0, width: 59, height: 59)
    static let calloutViewIdentifier = "customMKAnnotationView"
    static let imageViewerCellIdentifier = "imageViewerCellIdentifier"
    static let annotationFilter = "AnnotationFilterViewController"
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
        case id = "id"
        case name
        case description = "desc"
        case status = "status"
        case type = "type"
        case image = "img"
        case href
        case imageType = "imgtype"
        case smallImage = "thumbnail"
        case largeImage = "large"
        case version = "wpt-data-version"
    }
}

extension UserDefaults {
    struct Key {
        static let isAppAlreadyLaunchedOnce = "isAppAlreadyLaunchedOnce"
        static let appVersion = "appVersion"

        // swiftlint:disable type_name
        struct Sw {
            static let skatepark = "skatepark"
            static let skateshop = "stateshop"
            static let streetspot = "streetspot"
        }
    }
}

struct SegueIdentifier {
    static let showLocationPinDetails = "showLocationPinDetailsSegue"
    static let showImageViewer = "showImageViewerSegue"
}
