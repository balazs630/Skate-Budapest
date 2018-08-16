//
//  Waypoint.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 21..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import MapKit

public enum LocationType: String {
    case skatepark
    case skateshop
    case streetspot
}

class Waypoint: GPXEntry {
    // MARK: Properties
    var latitude: Double
    var longitude: Double

    var locationType: LocationType {
        let type = attributes[GPX.Tag.locationType.rawValue]
        guard let locationType = LocationType(rawValue: type!) else {
            fatalError("Unknown location type: \(String(describing: type))")
        }

        return locationType
    }

    var info: String? {
        return attributes[GPX.Tag.description.rawValue]
    }

    var thumbnailImageUrl: URL? {
        return images.imageURLsFor(type: GPX.Tag.smallImage.rawValue)[0]
    }

    var displayImageUrls: [URL?] {
        return images.imageURLsFor(type: GPX.Tag.largeImage.rawValue)
    }

    // MARK: Initializers
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

// MARK: MKAnnotation conformances
extension Waypoint: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var title: String? {
        return name
    }

    var subtitle: String? {
        return info
    }
}
