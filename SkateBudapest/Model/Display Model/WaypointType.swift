//
//  WaypointType.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2020. 04. 13..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

import UIKit

enum WaypointType: String, CaseIterable, Codable {
    case skatepark, skateshop, streetspot

    var pinIcon: UIImage {
        switch self {
        case .skatepark:
            return Theme.Icon.skateparkPin
        case .skateshop:
            return Theme.Icon.skateshopPin
        case .streetspot:
            return Theme.Icon.streetSpotPin
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .skatepark:
            return Theme.Color.skatepark
        case .streetspot:
            return Theme.Color.streetSpot
        case .skateshop:
            return Theme.Color.skateshop
        }
    }
}
