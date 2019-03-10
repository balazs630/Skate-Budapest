//
//  Constants.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

// swiftlint:disable next type_name

import UIKit

struct Constant {
    static let shortVersionString = "CFBundleShortVersionString"

    static let calloutImageViewSize = CGRect(x: 0, y: 0, width: 59, height: 59)
    static let calloutViewIdentifier = "customMKAnnotationView"
    static let imageViewerCellIdentifier = "imageViewerCellIdentifier"
}

enum ApiEnvironment: String {
    case production = "https://skate-budapest.vapor.cloud"

    var url: String {
        return rawValue
    }
}

enum StoryboardName: String {
    case skateMap = "SkateMap"
    case placeDetails = "PlaceDetails"
    case submitPlace = "SubmitPlace"
}

public enum Theme {
    public enum Icon {
        public static let mapIcon = UIImage(named: "map")!
        public static let addPinIcon = UIImage(named: "addPin")!

        public static let skateparkPin = UIImage(named: "map-pin-skatepark")!
        public static let skateshopPin = UIImage(named: "map-pin-shop")!
        public static let streetSpotPin = UIImage(named: "map-pin-city")!

        public static let filteringEmpty = UIImage(named: "filtering-empty")!
        public static let filteringFull = UIImage(named: "filtering-full")!

        public static let skateparkIcon = UIImage(named: "yellow")!
        public static let skateshopIcon = UIImage(named: "green")!
        public static let streetSpotIcon = UIImage(named: "purple")!
    }

    public enum Image {
        public static let placeholderSquare = UIImage(named: "placeholder-square")!
    }

    public enum Color {
        public static let primaryTurquoise = UIColor.color(red: 172, green: 235, blue: 203)
        public static let skateparkColor = UIColor.color(red: 210, green: 64, blue: 140)
        public static let skateshopColor = UIColor.color(red: 64, green: 200, blue: 140)
        public static let streetSpotColor = UIColor.color(red: 135, green: 200, blue: 240)
    }
}

extension UserDefaults {
    struct Key {
        static let isAppAlreadyLaunchedOnce = "isAppAlreadyLaunchedOnce"
        static let appVersion = "appVersion"

        struct Sw {
            static let skatepark = "skatepark"
            static let skateshop = "stateshop"
            static let streetspot = "streetspot"
        }
    }
}
