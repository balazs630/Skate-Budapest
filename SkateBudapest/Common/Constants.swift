//
//  Constants.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit
import MapKit

struct Constant {
    static let shortVersionString = "CFBundleShortVersionString"

    static let calloutImageViewSize = CGRect(x: 0, y: 0, width: 59, height: 59)
    static let calloutViewIdentifier = "customMKAnnotationView"
    static let imageViewerCellIdentifier = "imageViewerCellIdentifier"

    static let defaultCityCoordinate = CLLocationCoordinate2D(latitude: 47.500, longitude: 19.107)
    static let defaultCityRegion = MKCoordinateRegion(center: Constant.defaultCityCoordinate,
                                                      latitudinalMeters: 25000,
                                                      longitudinalMeters: 25000)

    struct Video {
        static let skatepark = "skatepark-preview"
        static let streetspot = "streetspot-preview"
        static let skateshop = "skateshop-preview"

        static let checkmark = "checkmark"
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
