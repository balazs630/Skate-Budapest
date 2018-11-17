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
    public enum Icon {
        public static let skateparkPin = UIImage(named: "yellow")!
        public static let skateshopPin = UIImage(named: "green")!
        public static let streetSpotPin = UIImage(named: "purple")!

        public static let skateparkIcon = UIImage(named: "yellow")!
        public static let skateshopIcon = UIImage(named: "green")!
        public static let streetSpotIcon = UIImage(named: "purple")!
    }

    public enum Color {
        public static let skateparkColor = UIColor.color(red: 210, green: 64, blue: 140)
        public static let skateshopColor = UIColor.color(red: 64, green: 200, blue: 140)
        public static let streetSpotColor = UIColor.color(red: 135, green: 200, blue: 240)
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

struct Texts {
    struct SkateMap {
        static let mapNavBarTitle = "mapNavBarTitle"
        static let mapTabBarTitle = "mapTabBarTitle"
        static let filteringFilter = "filteringFilter"
        static let filterTypeSkatepark = "filterTypeSkatepark"
        static let filterTypeSkatespot = "filterTypeSkatespot"
        static let filterTypeSkateshop = "filterTypeSkateshop"
    }

    struct LocationDetails {
        static let mapNavigationEmptyViewText = "mapNavigationEmptyViewText"
        static let mapNavigationEmptyViewButtonText = "mapNavigationEmptyViewButtonText"
    }

    struct SendSpace {
        static let sendPlaceNavBarTitle = "sendPlaceNavBarTitle"
        static let sendPlaceTabBarTitle = "sendPlaceTabBarTitle"
    }
}
