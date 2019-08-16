//
//  PlaceApiModel.swift
//  SkateBudapestBackend
//
//  Created by Horváth Balázs on 2018. 11. 21..
//

import UIKit

struct PlaceApiModel: Codable {
    var id: String
    var latitude: Double
    var longitude: Double
    var name: String
    var info: String
    var type: WaypointType
    var thumbnailUrl: String?
    var imageUrls: [String?]
}

enum WaypointType: String, CaseIterable, Codable {
    case skatepark, skateshop, streetspot

    var image: UIImage {
        switch self {
        case .skatepark:
            return Theme.Icon.skateparkPin
        case .skateshop:
            return Theme.Icon.skateshopPin
        case .streetspot:
            return Theme.Icon.streetSpotPin
        }
    }
}

enum WaypointStatus: String, Codable {
    case active, inactive, pending
}
