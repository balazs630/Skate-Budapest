//
//  CLLocationCoordinate2DExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 06. 16..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return (lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude)
    }
}
