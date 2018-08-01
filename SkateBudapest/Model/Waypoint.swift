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

class Waypoint: Entry {
    var latitude: Double
    var longitude: Double

    var locationType: LocationType {
        return LocationType(rawValue: attributes[GPX.Tag.locationType.rawValue]!)!
    }

    var info: String? {
        return attributes[GPX.Tag.description.rawValue]
    }

    // TODO: getImageURLsWith to extension
    var thumbnailImageUrl: URL? {
        return getImageURLsWith(type: GPX.Tag.smallImage.rawValue)[0]
    }

    var displayImageUrls: [URL?] {
        return getImageURLsWith(type: GPX.Tag.largeImage.rawValue)
    }

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        super.init()
    }
}

// MARK: Utility methods
extension Waypoint {
    private func getImageURLsWith(type: String) -> [URL?] {
        var imageUrls = [URL]()
        for image in images where image.type == type {
            if let imageUrl = image.url {
                imageUrls.append(imageUrl)
            }
        }

        return imageUrls
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
