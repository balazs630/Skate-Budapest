//
//  PlaceApiModel.swift
//  SkateBudapestBackend
//
//  Created by Horváth Balázs on 2018. 11. 21..
//

// swiftlint:disable next identifier_name

struct PlaceApiModel: Codable {
    var id: String
    var latitude: Double
    var longitude: Double
    var name: String
    var info: String
    var type: WaypointType
    var status: WaypointStatus
    var thumbnailUrl: String?
    var imageUrls: [String?]
}
