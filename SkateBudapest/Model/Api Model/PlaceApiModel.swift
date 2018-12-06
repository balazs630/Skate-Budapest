//
//  PlaceApiModel.swift
//  SkateBudapestBackend
//
//  Created by Horváth Balázs on 2018. 11. 21..
//

// swiftlint:disable next identifier_name
final class PlaceApiModel: Codable {
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
