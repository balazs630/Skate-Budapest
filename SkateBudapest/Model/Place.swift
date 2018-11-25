//
//  Place.swift
//  SkateBudapestBackend
//
//  Created by Horváth Balázs on 2018. 11. 21..
//

// swiftlint:disable identifier_name
import MapKit

final class Place: NSObject, Codable {
    var id: String
    var latitude: Double
    var longitude: Double
    var name: String
    var info: String
    var type: WaypointType
    var status: WaypointStatus
    var thumbnailUrl: String?
    var imageUrls: [String?]

    init(id: String,
         latitude: Double,
         longitude: Double,
         name: String,
         info: String,
         type: WaypointType,
         status: WaypointStatus,
         thumbnailUrl: String?,
         imageUrls: [String?]) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.info = info
        self.type = type
        self.status = status
        self.thumbnailUrl = thumbnailUrl
        self.imageUrls = imageUrls
    }
}

// MARK: MKAnnotation conformances
extension Place: MKAnnotation {
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
