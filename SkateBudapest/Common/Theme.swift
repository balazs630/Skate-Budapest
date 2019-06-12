//
//  Theme.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 23..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

enum Theme {
    enum Icon {
        static let mapIcon = UIImage(named: "map")!
        static let addPinIcon = UIImage(named: "addPin")!

        static let skateparkPin = UIImage(named: "map-pin-skatepark")!
        static let skateshopPin = UIImage(named: "map-pin-shop")!
        static let streetSpotPin = UIImage(named: "map-pin-city")!

        static let filteringEmpty = UIImage(named: "filtering-empty")!
        static let filteringFull = UIImage(named: "filtering-full")!

        static let skateparkIcon = UIImage(named: "yellow")!
        static let skateshopIcon = UIImage(named: "green")!
        static let streetSpotIcon = UIImage(named: "purple")!

        static let locationTrackingNone = UIImage(named: "location-tracking-none")!
        static let locationTrackingFollow = UIImage(named: "location-tracking-follow")!
        static let locationTrackingHeading = UIImage(named: "location-tracking-heading")!
    }

    enum Image {
        static let placeholderSquare = UIImage(named: "placeholder-square")!
        static let submitPlaceGraphics = UIImage(named: "add-place")!
        static let addImagePlaceholder = UIImage(named: "add-image")!
    }

    enum Color {
        static let primaryTurquoise = UIColor.color(red: 172, green: 235, blue: 203)
        static let lightBlue = UIColor.color(red: 15, green: 121, blue: 252)
        static let textDark = UIColor.color(red: 40, green: 40, blue: 40)
        static let loadingViewDark = UIColor.color(red: 50, green: 50, blue: 50)
        static let navbarLightGrey = UIColor.color(red: 248, green: 248, blue: 248)
        static let descriptionLabelLightGray = UIColor.color(red: 216, green: 216, blue: 216)

        static let skatepark = UIColor.color(red: 210, green: 64, blue: 140)
        static let skateshop = UIColor.color(red: 64, green: 200, blue: 140)
        static let streetSpot = UIColor.color(red: 135, green: 200, blue: 240)
    }
}
