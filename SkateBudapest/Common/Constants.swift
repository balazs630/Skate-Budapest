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
    static let annotationFilter = "AnnotationFilterViewController"
}

enum ApiEnvironment: String {
    case production = "https://skate-budapest.vapor.cloud"

    var url: String {
        return rawValue
    }
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

    public enum Image {
        public static let placeholderSquare = UIImage(named: "placeholder-square")!
    }

    public enum Color {
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

struct SegueIdentifier {
    static let showLocationPinDetails = "showLocationPinDetailsSegue"
    static let showImageViewer = "showImageViewerSegue"
}
