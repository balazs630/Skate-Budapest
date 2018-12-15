//
//  PlaceRealmModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 29..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

// swiftlint:disable next identifier_name

import RealmSwift

final class PlaceRealmModel: Object {
    @objc dynamic var id = ""
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    @objc dynamic var name = ""
    @objc dynamic var info = ""
    @objc dynamic var thumbnailImageData = Data()
    var imageDatas = List<Data?>()

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

    override class func primaryKey() -> String? {
        return "id"
    }
}

// MARK: Initializers
extension PlaceRealmModel {
    convenience init(_ placeApiModel: PlaceApiModel) {
        self.init()
        self.id = placeApiModel.id
        self.latitude = placeApiModel.latitude
        self.longitude = placeApiModel.longitude
        self.name = placeApiModel.name
        self.info = placeApiModel.info
        self.thumbnailImageData = ImageService.imageData(from: placeApiModel.thumbnailUrl, imageType: .thumbnail)
        placeApiModel.imageUrls.forEach { url in
            self.imageDatas.append(ImageService.imageData(from: url, imageType: .gallery))
        }
        self.type = placeApiModel.type
        self.status = placeApiModel.status
    }
}
