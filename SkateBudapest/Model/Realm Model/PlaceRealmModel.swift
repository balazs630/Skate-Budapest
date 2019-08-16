//
//  PlaceRealmModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 29..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

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
        placeApiModel.imageUrls.forEach { [weak self] url in
            guard let `self` = self else { return }
            self.imageDatas.append(ImageService.imageData(from: url, imageType: .gallery))
        }
        self.type = placeApiModel.type
    }
}
