//
//  Constants.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit
import CoreLocation

struct Constant {
    static let shortVersionString = "CFBundleShortVersionString"

    static let calloutImageViewSize = CGRect(x: 0, y: 0, width: 59, height: 59)
    static let calloutViewIdentifier = "customMKAnnotationView"
    static let imageViewerCellIdentifier = "imageViewerCellIdentifier"

    static let defaultCityCoordinate = CLLocationCoordinate2D(latitude: 47.499567, longitude: 19.046496)

    struct Video {
        static let skatepark = "skatepark-preview"
        static let streetspot = "streetspot-preview"
        static let skateshop = "skateshop-preview"
    }
}

enum ApiEnvironment: String {
    case development = "http://localhost:8080"
    case production = "https://skatebudapest.libertyskate.hu"

    var url: String {
        return rawValue
    }
}

enum StoryboardName: String {
    case skateMap = "SkateMap"
    case placeDetails = "PlaceDetails"
    case submitPlace = "SubmitPlace"
}

extension UserDefaults {
    struct Key {
        static let isAppAlreadyLaunchedOnce = "isAppAlreadyLaunchedOnce"
        static let appVersion = "appVersion"

        struct Switch {
            static let skatepark = "skatepark"
            static let skateshop = "stateshop"
            static let streetspot = "streetspot"
        }
    }
}
