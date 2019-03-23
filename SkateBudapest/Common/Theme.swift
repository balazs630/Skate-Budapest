//
//  Theme.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 23..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

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
        public static let loadingViewDark = UIColor.color(red: 50, green: 50, blue: 50)
        public static let skatepark = UIColor.color(red: 210, green: 64, blue: 140)
        public static let skateshop = UIColor.color(red: 64, green: 200, blue: 140)
        public static let streetSpot = UIColor.color(red: 135, green: 200, blue: 240)
    }
}
