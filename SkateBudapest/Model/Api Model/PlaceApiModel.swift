//
//  PlaceApiModel.swift
//  SkateBudapestBackend
//
//  Created by Horváth Balázs on 2018. 11. 21..
//

struct PlaceApiModel: Codable {
    // swiftlint:disable:next identifier_name
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

enum WaypointType: String, CaseIterable, Codable {
    case skatepark, skateshop, streetspot
}

enum WaypointStatus: String, Codable {
    case active, inactive, pending
}
