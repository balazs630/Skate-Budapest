//
//  PlaceDisplayItem.swift
//  SkateBudapestBackend
//
//  Created by Horváth Balázs on 2018. 11. 21..
//

import MapKit

final class PlaceDisplayItem: NSObject {
    // swiftlint:disable:next identifier_name
    var id: String
    var latitude: Double
    var longitude: Double
    var name: String
    var info: String
    var type: WaypointType
    var thumbnailImageData: Data
    var imageDatas: [Data?]

    init(_ placeRealmModel: PlaceRealmModel) {
        self.id = placeRealmModel.id
        self.latitude = placeRealmModel.latitude
        self.longitude = placeRealmModel.longitude
        self.name = placeRealmModel.name
        self.info = placeRealmModel.info
        self.type = placeRealmModel.type
        self.thumbnailImageData = placeRealmModel.thumbnailImageData
        self.imageDatas = placeRealmModel.imageDatas.map { $0 }
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
