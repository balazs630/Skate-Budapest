//
//  PlaceDisplayItem.swift
//  SkateBudapestBackend
//
//  Created by Horváth Balázs on 2018. 11. 21..
//

// swiftlint:disable next identifier_name
import MapKit

final class PlaceDisplayItem: NSObject {
    var id: String
    var latitude: Double
    var longitude: Double
    var name: String
    var info: String
    var type: WaypointType
    var status: WaypointStatus
    var thumbnailUrl: String?
    var imageUrls: [String?]

    init(_ placeApiModel: PlaceApiModel) {
        self.id = placeApiModel.id
        self.latitude = placeApiModel.latitude
        self.longitude = placeApiModel.longitude
        self.name = placeApiModel.name
        self.info = placeApiModel.info
        self.type = placeApiModel.type
        self.status = placeApiModel.status
        self.thumbnailUrl = placeApiModel.thumbnailUrl
        self.imageUrls = placeApiModel.imageUrls
    }

    init(_ placeRealmModel: PlaceRealmModel) {
        self.id = placeRealmModel.id
        self.latitude = placeRealmModel.latitude
        self.longitude = placeRealmModel.longitude
        self.name = placeRealmModel.name
        self.info = placeRealmModel.description
        self.type = placeRealmModel.type
        self.status = placeRealmModel.status
        self.thumbnailUrl = placeRealmModel.thumbnailUrl
        self.imageUrls = placeRealmModel.imageUrls.map { $0.name }
    }
}

// MARK: MKAnnotation conformances
extension PlaceDisplayItem: MKAnnotation {
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
