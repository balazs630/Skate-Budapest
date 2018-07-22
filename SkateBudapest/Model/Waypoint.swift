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
        set { attributes["desc"] = newValue }
        get { return attributes["desc"] }
    }

    var thumbnailImageUrl: URL? {
        return getImageUrl(type: "thumbnail")
    }

    var displayImageUrl: URL? {
        return getImageUrl(type: "large")
    }

    lazy var date: Date? = self.attributes["time"]?.asGpxDate

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        super.init()
    }
}

// MARK: Utility methods
extension Waypoint {
    private func getImageUrl(type: String) -> URL? {
        for link in links where link.type == type {
            return link.url
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
