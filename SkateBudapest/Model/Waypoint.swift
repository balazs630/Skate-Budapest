//
//  Waypoint.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 21..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import MapKit

class Waypoint: Entry {
    var latitude: Double
    var longitude: Double

    var info: String? {
        return attributes[GPX.Tag.description.rawValue]
    }

    var locationType: String? {
        return attributes[GPX.Tag.locationType.rawValue]
    }

    var thumbnailImageUrl: URL? {
        return getImageUrl(type: GPX.Tag.smallImage.rawValue)
    }

    var displayImageUrl: URL? {
        return getImageUrl(type: GPX.Tag.largeImage.rawValue)
    }

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        super.init()
    }
}

// MARK: Utility methods
extension Waypoint {
    private func getImageUrl(type: String) -> URL? {
        for image in images where image.type == type {
            return image.url
        }

        return nil
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
