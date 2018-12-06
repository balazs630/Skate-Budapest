//
//  PlaceRealmModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 29..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//
// swiftlint:disable next identifier_name

import RealmSwift

class PlaceRealmModel: Object {
    @objc dynamic var id = ""
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    @objc dynamic var name = ""
    @objc dynamic var info = ""
    @objc dynamic var thumbnailUrl: String?
    var imageUrls = List<ImageUrlRealmModel>()

    @objc private dynamic var typeEnum = WaypointType.skatepark.rawValue
    var type: WaypointType {
        get { return WaypointType(rawValue: typeEnum) ?? .skatepark }
        set { typeEnum = newValue.rawValue }
    }

    @objc private dynamic var statusEnum = WaypointStatus.active.rawValue
    var status: WaypointStatus {
        get { return WaypointStatus(rawValue: statusEnum) ?? .active }
        set { statusEnum = newValue.rawValue }
    }

    convenience init(id: String,
                     latitude: Double,
                     longitude: Double,
                     name: String,
                     info: String,
                     thumbnailUrl: String?,
                     imageUrls: List<ImageUrlRealmModel>,
                     type: WaypointType,
                     status: WaypointStatus) {
        self.init()
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.info = info
        self.thumbnailUrl = thumbnailUrl
        self.imageUrls = imageUrls
        self.type = type
        self.status = status
    }

    convenience init(_ placeApiModel: PlaceApiModel) {
        self.init()
        self.id = placeApiModel.id
        self.latitude = placeApiModel.latitude
        self.longitude = placeApiModel.longitude
        self.name = placeApiModel.name
        self.info = placeApiModel.info
        self.thumbnailUrl = placeApiModel.thumbnailUrl
        placeApiModel.imageUrls.forEach { url in
            self.imageUrls.append(ImageUrlRealmModel(name: url ?? ""))
        }
        self.type = placeApiModel.type
        self.status = placeApiModel.status
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
